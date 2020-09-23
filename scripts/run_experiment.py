#!/usr/bin/python3

import argparse
import pathlib
import queue
import sys
import time
import multiprocessing
from threading import Thread
import random


import bfasst

# Globals
ljust = 0
statuses = []
running_list = None
print_lock = None


def print_running_list():
    global running_list
    global print_lock

    print_lock.acquire()
    print("Running:", *running_list, end ="\r")
    print_lock.release()

def run_design(design, design_dir, flow_fcn):
    global running_list

    running_list.append(str(design.rel_path))
    print_running_list() 

    # time.sleep(random.randint(1,3))
    # status = None

    status = flow_fcn(design, design_dir)
    return (design,status)

def on_error(e, pool):
    pool.terminate()
    raise e

def job_done(retval):
    global running_list
    global print_lock

    design = retval[0]
    status = retval[1]

    print_lock.acquire()
    sys.stdout.write("\033[K")
    sys.stdout.write(str(design.rel_path).ljust(ljust))
    sys.stdout.flush()
    sys.stdout.write(str(status))
    sys.stdout.write("\n")
    print_lock.release()

    running_list.remove(str(design.rel_path))
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
    threads = [None] * no_threads
    experiment_queue = queue.Queue()
    results_queue = queue.Queue()

    # Build a list of work items
    designs_to_run = []
    for design in experiment.designs:
        # Create a per-design build directory
        design_dir = build_dir / design.rel_path
        design_dir.mkdir(parents=True, exist_ok = True)
        designs_to_run.append((design, design_dir, experiment.flow_fcn))


    manager = multiprocessing.Manager()
    running_list = manager.list()
    print_lock = manager.Lock()

    t_start = time.perf_counter()
    with multiprocessing.Pool(processes=no_threads) as pool:
        for design_to_run in designs_to_run:
            pool.apply_async(run_design, design_to_run, callback=job_done, error_callback=lambda e: on_error(e, pool))
        pool.close()
        pool.join()
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
