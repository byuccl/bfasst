#!/usr/bin/python3

import argparse
import pathlib
import queue
import sys
import time
import multiprocessing
import threading
from threading import Thread
import random
import datetime
import os


import bfasst

# Globals
ljust = 0
statuses = []
running_list = None
print_lock = None

def print_running_list():
    """ This function prints the list of jobs that are currently executing, and how long they have been running for """

    global running_list
    global print_lock

    print_lock.acquire()
    sys.stdout.write("\r\033[K")
    # sys.stdout.write("\033[u")
    sys.stdout.write("Running: ")
    for k,v in running_list.items()[:6]:
        sys.stdout.write(k + " (")    
        sys.stdout.write(str(datetime.datetime.now() - v).split(".")[0])
        sys.stdout.write(") ")
    if len(running_list) > 6:
        sys.stdout.write("...")
    sys.stdout.flush()
    print_lock.release()

def update_runtimes_thread(num_jobs):
    """ This function, designed to run in its own thread, calls print_running_list() periodically, until all jobs are done, or it is terminated. """

    inverval_seconds = 1.0

    global statuses
    if len(statuses) == num_jobs:
        sys.stdout.write("\r\033[K")
        print("All done")
        return
    print_running_list()
    threading.Timer(inverval_seconds, update_runtimes_thread, [num_jobs,]).start()

def run_design(design, design_dir, flow_fcn):
    """ This function runs a single job, running the selected CAD flow for one design """

    global running_list

    running_list[str(design.path.name)[:8]] = datetime.datetime.now()
    print_running_list() 

    # time.sleep(random.randint(1,2))
    # status = None
    status = flow_fcn(design, design_dir, print_to_stdout = False)
    return (design,status)

def on_error(e, pool, update_process):
    """ This should be called when a job process raises an exception.  This shuts down all jobs in the pool, as well as the update_process. """
    pool.terminate()
    if update_process is not None:
        update_process.terminate()
    raise e

def job_done(retval):
    """ Callback on job completion.  Removes job from the running_list, prints the job completion status, and saves the return status."""
    global running_list
    global print_lock

    design = retval[0]
    status = retval[1]

    print_lock.acquire()
    sys.stdout.write("\r\033[K")
    # sys.stdout.write("\033[u")
    sys.stdout.write(str(design.rel_path).ljust(ljust))
    sys.stdout.flush()
    sys.stdout.write(str(status))
    sys.stdout.write("\n")
    # sys.stdout.write("\033[s")
    print_lock.release()

    del running_list[str(design.path.name)[:8]]
    print_running_list() 


    statuses.append(status)

def main():
    global ljust
    global statuses
    global running_list
    global print_lock

    parser = argparse.ArgumentParser()

    # Set up command line arguments
    parser.add_argument("experiment_yaml", help="Experiment yaml file.")
    parser.add_argument("-j", "--threads", type=int, default=1, help="Number of threads")
    args = parser.parse_args()

    experiment_yaml_path = pathlib.Path(args.experiment_yaml)

    # Build experiment object
    experiment = bfasst.experiment.Experiment(experiment_yaml_path)

    # Create temp folder
    build_dir = pathlib.Path.cwd() / "build" / experiment.name
    if not build_dir.is_dir():
        build_dir.mkdir(parents=True)

    # Don't run with less than one thread
    if args.threads < 1:
        no_threads = 1
    else:
        no_threads = args.threads

    # For each design
    ljust = experiment.get_longest_design_name() + 5
    statuses = []

    # Build a list of work items
    designs_to_run = []
    for design in experiment.designs:
        # Create a per-design build directory
        design_dir = build_dir / design.rel_path
        design_dir.mkdir(parents=True, exist_ok = True)
        designs_to_run.append((design, design_dir, experiment.flow_fcn))


    manager = multiprocessing.Manager()
    running_list = manager.dict()
    print_lock = manager.Lock()

    t_start = time.perf_counter()
    sys.stdout.write("\033[s")
    update_process = multiprocessing.Process(target=update_runtimes_thread, args = [len(designs_to_run),])
    update_process.start()
    with multiprocessing.Pool(processes=no_threads) as pool:
        for design_to_run in designs_to_run:
            pool.apply_async(run_design, design_to_run, callback=job_done, error_callback=lambda e: on_error(e, pool, update_process))
        try:
            pool.close()
            pool.join()
        except:
            pool.terminate()
            update_process.terminate()
    update_process.terminate()
    t_end = time.perf_counter()

    if experiment.post_run is not None:
        experiment.post_run(build_dir)

    print("")
    print("-" * 80)
    print("Status By Type")
    print("-" * 80)

    # types_to_print = [  bfasst.status.SynthStatus,
    #                     bfasst.status.OptStatus,
    #                     bfasst.status.ImplStatus,
    #                     bfasst.status.BitReverseStatus,
    #                     bfasst.status.CompareStatus]

    j = 30
    print(
        "Synth Error:".ljust(j),
        len([s for s in statuses if type(s.status) == bfasst.status.SynthStatus and s.error]),
    )
    print(
        "Opt Error:".ljust(j),
        len([s for s in statuses if type(s.status) == bfasst.status.OptStatus and s.error]),
    )
    print(
        "Impl Error:".ljust(j),
        len([s for s in statuses if type(s.status) == bfasst.status.ImplStatus and s.error]),
    )
    print(
        "Bit Reverse Error:".ljust(j),
        len([s for s in statuses if type(s.status) == bfasst.status.BitReverseStatus and s.error]),
    )
    print(
        "Compare Error:".ljust(j),
        len(
            [
                s
                for s in statuses
                if type(s.status) == bfasst.status.CompareStatus
                and s.error
                and s.status != bfasst.status.CompareStatus.NOT_EQUIVALENT
            ]
        ),
    )
    print(
        "Compare Not Equivalent:".ljust(j),
        len([s for s in statuses if s.status == bfasst.status.CompareStatus.NOT_EQUIVALENT]),
    )
    print(
        "Compare Equivalent:".ljust(j),
        len([s for s in statuses if s.status == bfasst.status.CompareStatus.SUCCESS]),
    )

    # print(types)

    print("-" * 80)
    print("Execution took", t_end - t_start, "seconds")


if __name__ == "__main__":
    main()
