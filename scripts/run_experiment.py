""" Run experiment which runs multiple designs/flows in parallel """
from argparse import ArgumentParser
from collections import Counter
import datetime
import json
import multiprocessing
import os
import pathlib
import signal
import sys
import traceback
import threading
import time
import concurrent.futures

from bfasst.experiment import Experiment
from bfasst.output_cntrl import enable_proxy
from bfasst.tool import BfasstException
from bfasst.utils import TermColor, print_color

LOG_FILE_NAME = "log.txt"


def main(experiment, num_threads, print_period=1):  # pylint: disable=too-many-locals
    """Setup and run experiment as multiple processes"""

    # Capture Ctrl+C
    signal.signal(signal.SIGINT, signal.default_int_handler)

    # enable STDOUT redirects
    enable_proxy()

    # Build experiment object
    experiment = Experiment(experiment)

    # Ensure one thread minimum
    num_threads = max(1, num_threads)

    # Create jobs
    jobs = create_jobs(experiment)
    job_results = {}

    # Create shared memory
    statuses = multiprocessing.Manager().list()
    running_list = multiprocessing.Manager().dict()
    print_lock = multiprocessing.Manager().Lock()

    # Print number of designs
    print_color(TermColor.BLUE, f"Running {len(experiment.designs)} designs and {len(jobs)} jobs")

    # set the running_list to initial starttimes
    experiment.init_design_start_times(running_list)

    # Start the timer
    t_start = time.perf_counter()
    sys.stdout.write("\033[s")

    # Create update process and start it
    if print_period:
        update_process = multiprocessing.Process(
            target=update_runtimes_thread,
            args=[print_lock, jobs, running_list, statuses],
        )
        update_process.start()

    # Create a process pool executor to run the jobs
    with concurrent.futures.ProcessPoolExecutor(
        max_workers=num_threads, mp_context=multiprocessing.get_context("spawn")
    ) as pool:
        try:
            futures = []
            while jobs:
                futures = []
                for job in jobs:
                    if not job.dependencies:
                        future = pool.submit(
                            run_job,
                            print_lock,
                            running_list,
                            job,
                            statuses,
                            experiment,
                            jobs,
                        )
                        futures.append(future)
                        future.uuid = job.uuid
                for future in concurrent.futures.as_completed(futures):
                    clean_jobs(jobs, future, statuses, job_results, print_lock)

        except KeyboardInterrupt:
            if print_period:
                update_process.kill()
            jobs = None
            pool.shutdown(wait=False, cancel_futures=True)
            os.killpg(0, signal.SIGKILL)
        # except TypeError:
        #     os.killpg(0, signal.SIGKILL)

    if print_period:
        update_process.terminate()
        update_process.join()

    t_end = time.perf_counter()

    if experiment.post_run is not None:
        experiment.post_run(experiment.work_dir)

    with open(experiment.work_dir / "results.json", "w") as f:
        json.dump(job_results, f, indent=4)

    print_ending_stats(experiment, statuses, job_results, t_end - t_start)


def create_jobs(experiment):
    """Create and populate job container"""
    jobs = []
    for flow in experiment.flows:
        jobs.extend(flow.create())

    return jobs


def update_runtimes_thread(print_lock, jobs, running_list, statuses, print_period=1):
    """This function calls print_running_list every print_period seconds
    until all jobs are done or it is terminated. It runs in its own thread.
    """
    if len(jobs) == len(statuses):
        sys.stdout.write("\r\033[K")
        print("All done")
        return
    with print_lock:
        print_running_list(running_list)
    threading.Timer(
        print_period, update_runtimes_thread, args=[print_lock, jobs, running_list, statuses]
    ).start()


def print_running_list(running_list):
    """This function prints the list of jobs that are currently executing,
    and how long they have been running for"""

    sys.stdout.write("\r\033[K")
    sys.stdout.write("Running: ")
    for design_rel_path, start_time in running_list.items()[:6]:
        sys.stdout.write(design_rel_path.name[:8] + " (")
        sys.stdout.write(str(datetime.datetime.now() - start_time).split(".", maxsplit=1)[0])
        sys.stdout.write(") ")
    if len(running_list) > 6:
        sys.stdout.write("...")
    sys.stdout.flush()


def run_job(print_lock, running_list, job, statuses, experiment, jobs):
    """Run a single job and update running_list"""
    with print_lock:
        print_running_list(running_list)
    # Run the job:
    try:
        job.function()
        status = ""
    except BfasstException as e:
        status = f"{type(e).__name__}: {e}\n"
    except AssertionError:
        formatted_lines = traceback.format_exc().splitlines()
        line = ""
        for line in reversed(formatted_lines):
            if line.strip().startswith("File"):
                break
        status = f"AssertionErrror: {line}"

    # print the job status
    print_job_status(experiment, print_lock, statuses, job, status)

    # check the design statuses
    check_design_statuses(jobs, job, running_list)

    return status


def clean_jobs(jobs, future, statuses, job_results, print_lock):
    """Method to clean jobs as each job finishes"""

    # Get the job object associated with the finished job
    for job in jobs:
        if job.uuid == future.uuid:
            finished_job = job
            break

    if finished_job is None:
        raise ValueError("Finished job not found in jobs list")

    # Check for any unhandled exceptions
    if future.exception() is not None:
        with print_lock:
            print(f"\nException while running job: {finished_job.design_rel_path.name}")
            traceback.print_exception(future.exception())
            raise KeyboardInterrupt

    # read the result from the future
    status = future.result()

    job_results[finished_job.design_rel_path.name] = status

    # Remove the job and return if it was successful
    if not status:
        jobs.remove(finished_job)
        for job in jobs:
            if job.dependencies is not None:
                job.dependencies.discard(finished_job.uuid)
        return

    # If the job failed, trim that branch of the job tree
    jobs_to_remove = []
    clean_jobs_recursive(jobs, finished_job, jobs_to_remove, statuses)
    for job in jobs_to_remove:
        jobs.remove(job)


def clean_jobs_recursive(jobs, curr_job, jobs_to_remove, statuses):
    """Recursive helper to resolve job dependencies and remove jobs from the job list"""
    jobs_to_remove.append(curr_job)
    for job in jobs:
        if job.dependencies and curr_job.uuid in job.dependencies:
            statuses.append("Parent job failed")
            clean_jobs_recursive(jobs, job, jobs_to_remove, statuses)


def print_job_status(experiment, print_lock, statuses, job, status):
    """Print job status"""

    ljust = experiment.get_length_of_longest_design_name() + 5
    with print_lock:
        if status:
            sys.stdout.write("\r\033[K")
            sys.stdout.write(job.design_rel_path.name.ljust(ljust))
            sys.stdout.flush()
            sys.stdout.write(f"{status}\n")

    statuses.append(status)


def check_design_statuses(jobs, curr_job, running_list):
    for job in jobs:
        if curr_job.design_rel_path == job.design_rel_path:
            return
    del running_list[curr_job.design_rel_path]
    print_running_list(running_list)


def print_ending_stats(experiment, statuses, job_results, runtime):
    """Print statistcs upon completion of all jobs"""
    print_color(TermColor.BLUE, f"\nRan {len(statuses)} jobs")
    print("-" * 80)
    print("Status By Type:")
    print("-" * 80)

    exception_exists = any(s != "" for s in statuses)

    # Convert empty strings to "Success"
    statuses = ["Success" if status == "" else status for status in statuses]

    # Print status by type
    if statuses:
        status_counts = Counter(statuses)

        padding = min(max(len(status) for status in status_counts) + 10, 80)
        for status, count in status_counts.items():
            print(f"{status.strip().ljust(padding)} {count}")

    print("-" * 80)
    print("Results by Design:")
    print("-" * 80)
    ljust = experiment.get_length_of_longest_design_name() + 5
    for design, status in sorted(job_results.items()):
        status = "Success" if not status else status
        print(f"{design.ljust(ljust)} {status}")
    print("-" * 80)
    print(f"Execution took {round(runtime, 1)} seconds")
    if exception_exists:
        print_color(
            TermColor.YELLOW, "Exception(s) occurred. See log files for full exception trace."
        )

    if exception_exists:
        sys.exit(1)
    else:
        print("Completed successfully")


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("experiment_yaml", type=pathlib.Path, help="Experiment yaml file.")
    parser.add_argument("-j", "--threads", type=int, default=1, help="Number of threads")
    parser.add_argument("--print_period", type=int, default=1)
    args = parser.parse_args()
    main(args.experiment_yaml, args.threads, args.print_period)
