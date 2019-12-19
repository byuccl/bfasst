#!/usr/bin/python3.6

import argparse
import glob
import sys
import pathlib
from threading import Thread
import time
import queue

import bfasst


def main():
    parser = argparse.ArgumentParser()

    # Find all experiments in the experiments/ directory
    experiments = []
    for dir_item in bfasst.EXPERIMENTS_PATH.glob('*'):
        if (bfasst.EXPERIMENTS_PATH / dir_item).is_file() and dir_item.suffix == ".yaml":
            experiments.append(dir_item.stem)

    # Set up command line arguments
    parser.add_argument("experiment_name", choices=experiments,
                        help="Name of folder in experiments directory (with experiment.yaml file).")
    parser.add_argument("--force", action='store_true')
    parser.add_argument("-j", "--threads", type=int, help="Number of threads")
    args = parser.parse_args()

    # Build experiment object
    experiment = bfasst.experiment.Experiment(args.experiment_name)

    # Create temp folder
    build_dir = pathlib.Path.cwd() / "build" / args.experiment_name
    if not build_dir.is_dir():
        build_dir.mkdir(parents = True)
    elif not args.force:
        bfasst.utils.error("Build directory", build_dir, "already exists.  Use --force to overwrite")
    else:
        pass

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

    def flow_fcn_wrapper(design, design_dir, res_q):
        status = experiment.flow_fcn(design, design_dir)
        res_q.put((design, status))
    
    for i in range(len(experiment.designs)):

        design = experiment.designs[i]
        # Create a per-design build directory
        design_dir = build_dir / design.top
        try:
            design_dir.mkdir()
        except FileExistsError:
            pass
        
        experiment_queue.put((design, design_dir))

    t_start = time.perf_counter()
    while(experiment_queue.qsize()):
        # loop through the list of threads and look for any that are done
        for i in range(len(threads)):
            if threads[i] == None:
                # Start a thread in this slot
                design, design_dir = experiment_queue.get()
                threads[i] = Thread(target = flow_fcn_wrapper, args=(design, design_dir, results_queue))
                threads[i].start()
                if not experiment_queue.qsize(): break
            elif not threads[i].is_alive():
                # There is a thread here, but it's finished running
                # Print results and start a new thread (if there is one)
                design, status = results_queue.get()
                sys.stdout.write(design.design_dir.ljust(ljust))
                sys.stdout.flush()
                sys.stdout.write(str(status))
                sys.stdout.write("\n")
                statuses.append(status)
                # start the new thread
                design, design_dir = experiment_queue.get()
                threads[i] = Thread(target = flow_fcn_wrapper, args=(design, design_dir, results_queue))
                threads[i].start()
                if not experiment_queue.qsize(): break
        time.sleep(1)

    # By now all of our experiments either have run or are running
    # Wait for the rest of them to finish
    all_threads_done = False
    done_threads = [False] * len(threads)
    while not all_threads_done:
        all_threads_done = True
        for i in range(len(threads)):
            if threads[i].is_alive():
                all_threads_done = False
            if (not threads[i].is_alive()) and (done_threads[i] == False):
                done_threads[i] = True
                design, status = results_queue.get()
                sys.stdout.write(design.design_dir.ljust(ljust))
                sys.stdout.flush()
                sys.stdout.write(str(status))
                sys.stdout.write("\n")
                statuses.append(status)
        time.sleep(1)
    t_end = time.perf_counter()

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
    print("Synth Error:".ljust(j), len([s for s in statuses if type(s.status) == bfasst.status.SynthStatus and s.error]))
    print("Opt Error:".ljust(j), len([s for s in statuses if type(s.status) == bfasst.status.OptStatus and s.error]))
    print("Impl Error:".ljust(j), len([s for s in statuses if type(s.status) == bfasst.status.ImplStatus and s.error]))
    print("Bit Reverse Error:".ljust(j), len([s for s in statuses if type(s.status) == bfasst.status.BitReverseStatus and s.error]))
    print("Compare Error:".ljust(j), len([s for s in statuses if type(s.status) == bfasst.status.CompareStatus and s.error and s.status != bfasst.status.CompareStatus.NOT_EQUIVALENT]))
    print("Compare Not Equivalent:".ljust(j), len([s for s in statuses if s.status == bfasst.status.CompareStatus.NOT_EQUIVALENT]))
    print("Compare Equivalent:".ljust(j), len([s for s in statuses if s.status == bfasst.status.CompareStatus.SUCCESS]))


    # print(types)

    print("-" * 80)
    print("Execution took", t_end - t_start, "seconds")


if __name__ == "__main__":
    main()
