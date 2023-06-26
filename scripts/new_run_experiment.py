""" Run experiment which runs multiple designs/flows in parallel """
from argparse import ArgumentParser
import datetime
import functools
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


def main(experiment_yaml, num_threads, print_period=1):
    """Setup and run experiment as multiple processes"""

    # Capture Ctrl+C
    signal.signal(signal.SIGINT, signal.default_int_handler)

    # enable STDOUT redirects
    enable_proxy()

    # Build experiment object
    experiment = Experiment(experiment_yaml)

    # Create and populate job queue
    jobs = create_job_queue(experiment)

    # Ensure one thread minimum
    num_threads = max(1, num_threads)

    # Create shared memory
    statuses = multiprocessing.Manager().list()
    running_list = multiprocessing.Manager().dict()
    print_lock = multiprocessing.Manager().Lock()
    job_queue_lock = multiprocessing.Manager().Lock()

    # Print number of designs
    print_color(TermColor.BLUE, f"Running {len(experiment.designs)} designs")

    # Start the timer
    t_start = time.perf_counter()
    sys.stdout.write("\033[s")

    # Create update process and start it
    if print_period:
        update_process = multiprocessing.Process(
            target=update_runtimes_thread,
            args=[print_lock, len(experiment.designs), running_list, statuses],
        )
        update_process.start()

    # Create process pool
    with concurrent.futures.ProcessPoolExecutor(
        max_workers=num_threads, mp_context=multiprocessing.get_context("spawn")
    ) as pool:
        try:
            while jobs:
                current_job_futures = []
                for job in jobs:
                    if not job.dependencies:
                        future = pool.submit(run_job, print_lock, running_list, job)
                        future.add_done_callback(
                            functools.partial(
                                clean_job_queue,
                                future,
                                jobs,
                                job_queue_lock,
                            )
                        )
                        future.add_done_callback(
                            functools.partial(
                                print_job_status,
                                experiment,
                                print_lock,
                                running_list,
                                statuses,
                                future,
                            )
                        )

                        current_job_futures.append(future)
                        concurrent.futures.wait(
                            current_job_futures,
                            timeout=None,
                            return_when=concurrent.futures.ALL_COMPLETED,
                        )
        except KeyboardInterrupt:
            # If interupted, kill all processes
            os.killpg(0, signal.SIGKILL)

    if print_period:
        update_process.terminate()
        update_process.join()

    t_end = time.perf_counter()

    if experiment.post_run is not None:
        experiment.post_run(experiment.work_dir)

    print_ending_stats(statuses, t_end - t_start)


def create_job_queue(experiment):
    """Create and populate job queue"""
    jobs = []
    for flow in experiment.flows:
        jobs.extend(flow.create())

    return jobs


def update_runtimes_thread(print_lock, num_jobs, running_list, statuses, print_period=1):
    """This function calls print_running_list every print_period seconds
    until all jobs are done or it is terminated. It runs in its own thread.
    """

    if len(statuses) == num_jobs:
        sys.stdout.write("\r\033[K")
        print("All done")
        return
    with print_lock:
        print_running_list(running_list)
    threading.Timer(
        print_period, update_runtimes_thread, args=[print_lock, num_jobs, running_list, statuses]
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


def run_job(print_lock, running_list, job):
    """Run a single job and update running_list"""
    enable_proxy()

    running_list[job.design.rel_path] = datetime.datetime.now()
    with print_lock:
        print_running_list(running_list)

    # Run the job:
    try:
        job.function()
        status = ""
    except BfasstException as e:
        status = f"{type(e).__name__}: {e}"

    return (job, status)


def clean_job_queue(future, job_queue, job_queue_lock):
    curr_job, status = future.result()
    with job_queue_lock:
        if status != "":
            # remove all jobs from the queue that depend on this job
            for job in job_queue:
                if curr_job in job.dependencies:
                    job_queue.remove(job)

        # remove this job from the queue
        job_queue.remove(curr_job)


def print_job_status(experiment, print_lock, running_list, statuses, future):
    """Print job status"""
    ljust = experiment.get_length_of_longest_design_name() + 5
    with print_lock:
        status = future.result()[1]

        sys.stdout.write("\r\033[K")
        sys.stdout.write(str(design.rel_path.name).ljust(ljust))
        sys.stdout.flush()
        sys.stdout.write(str(status))

        del running_list[design.rel_path]
        print_running_list(running_list)

    statuses.append(status)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("experiment_yaml", type=pathlib.Path, help="Experiment yaml file.")
    parser.add_argument("-j", "--threads", type=int, default=1, help="Number of threads")
    parser.add_argument("--print_period", type=int, default=1)
    args = parser.parse_args()
    main(args.experiment_yaml, args.threads, args.print_period)
