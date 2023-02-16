#!/usr/bin/python3
from argparse import ArgumentParser
import atexit
import collections
import datetime
import multiprocessing
import os
import pathlib
from shutil import copyfileobj
import signal
import sys
import threading
import time
import concurrent.futures
import traceback


import bfasst
from bfasst.output_cntrl import redirect, cleanup_redirect, enable_proxy
from bfasst.status import BfasstException, Status
from bfasst.utils import TermColor, print_color

# Globals
ljust = 0
statuses = None
running_list = None
print_lock = None


def print_running_list():
    """This function prints the list of jobs that are currently executing, and how long they have been running for"""

    global running_list
    global print_lock

    print_lock.acquire()
    sys.stdout.write("\r\033[K")
    sys.stdout.write("Running: ")
    for design_rel_path, start_time in running_list.items()[:6]:
        sys.stdout.write(design_rel_path.name[:8] + " (")
        sys.stdout.write(str(datetime.datetime.now() - start_time).split(".")[0])
        sys.stdout.write(") ")
    if len(running_list) > 6:
        sys.stdout.write("...")
    sys.stdout.flush()
    print_lock.release()


def update_runtimes_thread(num_jobs):
    """This function, designed to run in its own thread, calls print_running_list() periodically, until all jobs are done, or it is terminated."""

    # signal.signal(signal.SIGINT, signal.SIG_IGN)
    inverval_seconds = 1.0

    global statuses
    if len(statuses) == num_jobs:
        sys.stdout.write("\r\033[K")
        print("All done")
        return
    print_running_list()
    threading.Timer(
        inverval_seconds,
        update_runtimes_thread,
        [
            num_jobs,
        ],
    ).start()


def init_worker():
    signal.signal(signal.SIGINT, signal.SIG_IGN)


def run_design(design, design_dir, flow_fcn, flow_args):
    """This function runs a single job, running the selected CAD flow for one design"""
    global running_list

    running_list[design.rel_path] = datetime.datetime.now()
    print_running_list()

    # time.sleep(random.randint(1,2))
    # status = None
    buf = redirect()
    try:
        status = flow_fcn(design=design, build_dir=design_dir, flow_args=flow_args)
    except BfasstException as e:
        status = Status(status=e.error, msg=str(e), raise_excep=False)
    finally:
        with open(f"{design_dir / design.path.name}.log", "w") as f:
            buf.seek(0)
            copyfileobj(buf, f)
        cleanup_redirect()
    return (design, status)


def job_done(future):
    """Removes job from the running_list, prints the job completion status, and saves the return status."""

    global running_list
    global print_lock
    # def on_success(future):
    # """Callback on job completion."""

    design = future.design

    print_lock.acquire()

    if future.exception():
        status = future.exception()
        print(traceback.print_exception(status))
    else:
        status = future.result()[1]

    sys.stdout.write("\r\033[K")
    # sys.stdout.write("\033[u")
    sys.stdout.write(str(design.rel_path).ljust(ljust))
    sys.stdout.flush()
    sys.stdout.write(str(status))
    sys.stdout.write("\n")
    # sys.stdout.write("\033[s")
    print_lock.release()

    del running_list[design.rel_path]
    print_running_list()

    statuses.append(status)


def cleanup():
    os.killpg(0, signal.SIGKILL)  # kill all processes in my group


def main(experiment_yaml, threads):
    global ljust
    global statuses
    global running_list
    global print_lock

    os.setpgrp()  # create new process group, become its leader

    atexit.register(cleanup)

    # Make sure we capture Ctrl+C
    signal.signal(signal.SIGINT, signal.default_int_handler)

    enable_proxy()  # Enable STDOUT redirects

    experiment_yaml_path = pathlib.Path(experiment_yaml)

    # Build experiment object
    experiment = bfasst.experiment.Experiment(experiment_yaml_path)

    # Create temp folder
    build_dir = pathlib.Path.cwd() / "build" / experiment.name
    if not build_dir.is_dir():
        build_dir.mkdir(parents=True)

    # Don't run with less than one thread
    if threads < 1:
        no_threads = 1
    else:
        no_threads = threads

    # For each design
    ljust = experiment.get_longest_design_name() + 5

    # Build a list of work items
    designs_to_run = []
    for design in experiment.designs:
        # Create a per-design build directory
        design_dir = build_dir / design.rel_path
        design_dir.mkdir(parents=True, exist_ok=True)
        designs_to_run.append((design, design_dir, experiment.flow_fcn, experiment.flow_args))

    manager = multiprocessing.Manager()
    statuses = manager.list()
    running_list = manager.dict()
    print_lock = manager.Lock()  #  pylint: disable=E1101

    # original_sigint_handler = signal.signal(signal.SIGINT, signal.SIG_IGN)

    print_color(TermColor.BLUE, "Running", len(designs_to_run), "designs")

    t_start = time.perf_counter()
    sys.stdout.write("\033[s")

    update_process = multiprocessing.Process(
        target=update_runtimes_thread,
        args=[
            len(designs_to_run),
        ],
    )
    update_process.start()

    results = []
    with concurrent.futures.ProcessPoolExecutor(
        max_workers=no_threads,
    ) as pool:
        for design_to_run in designs_to_run:
            design = design_to_run[0]

            future = pool.submit(run_design, *design_to_run)
            future.design = design
            future.add_done_callback(job_done)
            results.append(future)

        try:
            pool.shutdown(wait=True)
        except KeyboardInterrupt:
            print("Keyboard!")
            pool.shutdown(wait=False)

    update_process.terminate()
    update_process.join()
    t_end = time.perf_counter()

    if experiment.post_run is not None:
        experiment.post_run(build_dir)

    print_color(TermColor.BLUE, "\nRan", len(statuses), "jobs")
    print("")
    print("-" * 80)
    print("Status By Type")
    print("-" * 80)
    if statuses:
        status_counts = collections.Counter(statuses)

        pad = max(len(str(status)) for status in status_counts) + 10
        for status, count in status_counts.items():
            print(str(status).ljust(pad), count)

    print("-" * 80)
    print("Execution took", round(t_end - t_start, 1), "seconds")

    os.killpg(0, signal.SIGKILL)  # kill all processes in my group


if __name__ == "__main__":
    parser = ArgumentParser()
    # Set up command line arguments
    parser.add_argument("experiment_yaml", help="Experiment yaml file.")
    parser.add_argument("-j", "--threads", type=int, default=1, help="Number of threads")
    args = parser.parse_args()
    main(args.experiment_yaml, args.threads)
