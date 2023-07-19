""" Run experiment which runs multiple designs/flows in parallel """
from argparse import ArgumentParser
from collections import Counter
import datetime
import multiprocessing
import os
import pathlib
import signal
import sys
import threading
import time
import concurrent.futures
from bfasst.experiment import Experiment

from bfasst.output_cntrl import enable_proxy
from bfasst.tool import BfasstException
from bfasst.utils import TermColor, print_color

LOG_FILE_NAME = "log.txt"


def main(experiment_yaml, num_threads, print_period=1):
    """Setup and run experiment as multiple processes"""

    # Capture Ctrl+C
    signal.signal(signal.SIGINT, signal.default_int_handler)

    # enable STDOUT redirects
    enable_proxy()

    # Build experiment object
    experiment = Experiment(experiment_yaml)

    # Ensure one thread minimum
    num_threads = max(1, num_threads)

    # Create jobs
    jobs = create_jobs(experiment)

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
                for future in concurrent.futures.as_completed(futures):
                    clean_jobs(jobs, future, statuses)

        except KeyboardInterrupt:
            jobs = None
            os.killpg(0, signal.SIGKILL)
        # except TypeError:
        #     os.killpg(0, signal.SIGKILL)

    if print_period:
        update_process.terminate()
        update_process.join()

    t_end = time.perf_counter()

    if experiment.post_run is not None:
        experiment.post_run(experiment.work_dir)

    print_ending_stats(statuses, t_end - t_start)


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

    # print the job status
    print_job_status(experiment, print_lock, statuses, job, status)

    # check the design statuses
    check_design_statuses(jobs, job, running_list)

    return (job.uuid, status)


def clean_jobs(jobs, future, statuses):
    """Method to clean jobs as each job finishes"""

    # read the result from the future
    finished_job_uuid = future.result()[0]
    status = future.result()[1]

    # Get the job object associated with the finished job
    for job in jobs:
        if job.uuid == finished_job_uuid:
            finished_job = job
            break

    if finished_job is None:
        raise ValueError("Finished job not found in jobs list")

    # Remove the job and return if it was successful
    if not status:
        jobs.remove(finished_job)
        for job in jobs:
            if job.dependencies is not None:
                job.dependencies.discard(finished_job_uuid)
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
        if status != "":
            sys.stdout.write("\r\033[K")
            sys.stdout.write(str(job.design_rel_path.name).ljust(ljust))
            sys.stdout.flush()
            sys.stdout.write(str(status))

    statuses.append(status)


def check_design_statuses(jobs, curr_job, running_list):
    for job in jobs:
        if curr_job.design_rel_path == job.design_rel_path:
            return
    del running_list[curr_job.design_rel_path]
    print_running_list(running_list)


def print_ending_stats(statuses, runtime):
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
