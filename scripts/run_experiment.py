#!/usr/bin/python3

import argparse
from glob import glob
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
from prettytable import from_html_one
import json


import bfasst
from bfasst.utils import TermColor, print_color

# Globals
ljust = 0
statuses = None
running_list = None
print_lock = None
designs_list = []


def print_running_list():
    """ This function prints the list of jobs that are currently executing, and how long they have been running for """

    global running_list
    global print_lock

    print_lock.acquire()
    sys.stdout.write("\r\033[K")
    # sys.stdout.write("\033[u")
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
    """ This function, designed to run in its own thread, calls print_running_list() periodically, until all jobs are done, or it is terminated. """

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



def chk_html(html_path):
    if os.path.getsize(os.path.abspath(html_path)) == 0:
        tmp_html = open(html_path, "w")
        tmp_html.write("<!DOCTYPE html>\n<html>\n<style>\ntable, th, td {\n\tborder:1px solid black;\n}\n</style>\n<body>\n\n<h2>BFASST Experiment Runs and Results</h2>\n")
        tmp_html.write("<table>\n<thead>\n\t<tr>\n\t\t<th>Design</th>\n\t\t<th>IC2_lse_conformal</th>\n\t\t<th>IC2_synplify_conformal</th>\n\t\t<th>synplify_IC2_icestorm_onespin</th> \
        \n\t\t<th>yosys_tech_lse_conformal</th>\n\t\t<th>yosys_tech_synplify_conformal</th>\n\t\t<th>yosys_tech_synplify_onespin</th>\n\t\t<th>yosys_synplify_error_onespin</th>\n\t\t \
        <th>xilinx_conformal</th>\n\t\t<th>xilinx_conformal_impl</th>\n\t\t<th>xilinx_yosys_impl</th>\n\t\t<th>xilinx_yosys_waveform</th>\n\t\t<th>gather_impl_data</th>\n\t\t<th>conformal_only</th> \
        \n\t\t<th>xilinx</th>\n\t</tr>\n</thead>\n<tbody>\n</tbody>\n</table>")
        tmp_html.write("\n\n<p>To run these designs yourself, check out the <a href=\"https://github.com/byuccl/bfasst\">BFASST Github repository</a>.</p>\n\n</body>\n</html>")
        tmp_html.close()



def write_html(htmlStr, idx_html_path):
    yes_str = "<td>Yes</td>"
    no_str = "<td>No</td>"
    yes_style = " style=\"background-color:darkseagreen;color:black;\""
    no_style = " style=\"background-color:lightcoral;color:black;\""
    while htmlStr.find(yes_str) != -1:
        index = htmlStr.find(yes_str)
        htmlStr = htmlStr[:index+3] + yes_style + htmlStr[index+3:]
    while htmlStr.find(no_str) != -1:
        index = htmlStr.find(no_str)
        htmlStr = htmlStr[:index+3] + no_style + htmlStr[index+3:]


    htmlFile = open(idx_html_path, "w")
    htmlFile.write("<!DOCTYPE html>\n<html>\n<style>\ntable, th, td {\n\tborder:1px solid black;\n}\n</style>\n<body>\n\n<h2>BFASST Experiment Runs and Results</h2>\n")
    htmlFile.write("\n" + htmlStr)
    htmlFile.write("\n\n<p>To run these designs yourself, check out the <a href=\"https://github.com/byuccl/bfasst\">BFASST Github repository</a>.</p>\n\n</body>\n</html>")
    htmlFile.close()



def html_update(equivalence, design, flow_fcn):
    flows_list = ["IC2_lse_conformal", "IC2_synplify_conformal", "synplify_IC2_icestorm_onespin", 
    "yosys_tech_lse_conformal", "yosys_tech_synplify_conformal", "yosys_tech_synplify_onespin", 
    "yosys_synplify_error_onespin", "xilinx_conformal", "xilinx_conformal_impl", "xilinx_yosys_impl", 
    "xilinx_yosys_waveform", "gather_impl_data", "conformal_only", "xilinx"]

    idx_html_path = "./index.html"

    if str(equivalence).find("Equivalent") != -1:
        table_value = "Yes"
    elif str(equivalence).find("Not equivalent") != -1:
        table_value = "No"
    else:
        table_value = "ERROR"

    flow_name = flow_fcn.split()
    curr_flow = flow_name[1][5:]

    flow_dict = dict.fromkeys(flows_list, "Not Run Yet")
    for flow in flows_list:
        if flow == curr_flow:
            flow_dict[flow] = table_value

    chk_html(idx_html_path)
    with open(idx_html_path, "r") as fp:
        html = fp.read()

    x = from_html_one(html)
    x_json = json.loads(x.get_json_string())

    if design in x.get_json_string():
        for i in range(len(x_json)):
            curr_x_json = x_json[i]
            if design in str(curr_x_json):
                if curr_x_json[curr_flow] != flow_dict[curr_flow] and flow_dict[curr_flow] != "Not Run Yet":
                    curr_x_json[curr_flow] = flow_dict[curr_flow]
                for f in flows_list:
                    if f != curr_flow:
                        flow_dict[f] = curr_x_json[f]
                x.del_row(i-1)
                break

    temp_list = [flow_dict[column] for column in flows_list]
    temp_list.insert(0, design)
    x.add_row(temp_list)

    write_html(x.get_html_string(), idx_html_path)



def list_maker(design_dict={}, go=False):

    global designs_list
    idx_html_path = "./index.html"
    if design_dict != {}:
        file1 = open("temp.txt", "a+")  # append mode
        json.dump(design_dict, file1)
        file1.write("\n")
        file1.close()
    if go:
        try:
            file1 = open("temp.txt", "r")
            line = file1.readline()
            while line:
                json_temp = json.loads(line)
                line = file1.readline()
                html_update(json_temp["status"], json_temp["design"], json_temp["flow_fcn"])
            file1.close()
            os.remove("temp.txt")
        except:
            chk_html(idx_html_path)
            print("index.html unchanged") # Do nothing



def run_design(design, design_dir, flow_fcn):
    """ This function runs a single job, running the selected CAD flow for one design """

    global running_list
    global designs_list

    running_list[design.rel_path] = datetime.datetime.now()
    print_running_list()

    # time.sleep(random.randint(1,2))
    # status = None
    status = flow_fcn(design, design_dir, print_to_stdout=False)
    path = pathlib.PurePath(design_dir)
    design_dict = {"design": path.name, "status": str(status), "flow_fcn": str(flow_fcn).casefold()}
    design_dict_copy = design_dict.copy()
    list_maker(design_dict=design_dict_copy)
    return (design, status)


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

    del running_list[design.rel_path]
    print_running_list()

    statuses.append(status)


def main():
    global ljust
    global statuses
    global running_list
    global print_lock
    global designs_list

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

    # Build a list of work items
    designs_to_run = []
    for design in experiment.designs:
        # Create a per-design build directory
        design_dir = build_dir / design.rel_path
        design_dir.mkdir(parents=True, exist_ok=True)
        designs_to_run.append((design, design_dir, experiment.flow_fcn))

    manager = multiprocessing.Manager()
    statuses = manager.list()
    running_list = manager.dict()
    print_lock = manager.Lock()

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
    with multiprocessing.Pool(processes=no_threads) as pool:
        for design_to_run in designs_to_run:
            pool.apply_async(
                run_design,
                design_to_run,
                callback=job_done,
                error_callback=lambda e: on_error(e, pool, update_process),
            )
        try:
            pool.close()
            pool.join()
        except:
            pool.terminate()
            pool.join()
            update_process.terminate()
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
    list_maker(go=True)
    print("Execution took", round(t_end - t_start,1), "seconds")


if __name__ == "__main__":
    main()
