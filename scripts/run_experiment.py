""" Run experiment which runs multiple designs/flows in parallel """

from argparse import ArgumentParser
import collections
import datetime
import functools
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
import bfasst.experiment
from bfasst.output_cntrl import redirect, cleanup_redirect, enable_proxy
from bfasst.status import BfasstException, Status
from bfasst.utils import TermColor, print_color


LOG_FILE_NAME = "log.txt"


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


def update_runtimes_thread(print_lock, num_jobs, running_list, statuses, period=1):
    """This function, designed to run in its own thread,
    calls print_running_list() periodically, until all jobs are done,
    or it is terminated."""

    if len(statuses) == num_jobs:
        sys.stdout.write("\r\033[K")
        print("All done")
        return
    with print_lock:
        print_running_list(running_list)
    threading.Timer(
        period,
        update_runtimes_thread,
        (print_lock, num_jobs, running_list, statuses),
    ).start()


def chk_html(html_path, flows_list):
    """This function checks to see if an html file exists.
    If one does not exist one is made and filled with the
    base code."""

    if Path(html_path).resolve().is_file() == 0:
        tmp_html = open(html_path, "w")
        tmp_html.write(
            "<!DOCTYPE html>\n<html>\n<style>\ntable, th, td     \
         {\n\tborder:1px solid black;\n}\n</style>\n<body>\n\n<h2>BFASST    \
          Experiment Runs and Results</h2>\n"
        )
        tmp_html.write("<table>\n<thead>\n\t<tr>\n\t\t<th>Design</th>")
        for flow in flows_list:
            tmp_html.write("\n\t\t<th>" + str(flow) + "</th>")
        tmp_html.write(
            '\n\t</tr>\n</thead>\n<tbody>\n</tbody>\n</table>    \
        \n\n<p>To run these designs yourself, check out the <a href="htt   \
        ps://github.com/byuccl/bfasst">BFASST Github repository</a>.</p>\n\n</body>\n</html>'
        )
        tmp_html.close()


def write_html(html_str, idx_html_path):
    """This function reads the html for yeses and nos
    of each experiment run and changes the color
    to green if yes and red if no."""

    yes_str = "<td>Yes</td>"
    no_str = "<td>No</td>"
    yes_style = ' style="background-color:darkseagreen;color:black;"'
    no_style = ' style="background-color:lightcoral;color:black;"'

    while html_str.find(yes_str) != -1:
        index = html_str.find(yes_str)
        html_str = html_str[: index + 3] + yes_style + html_str[index + 3 :]

    while html_str.find(no_str) != -1:
        index = html_str.find(no_str)
        html_str = html_str[: index + 3] + no_style + html_str[index + 3 :]

    html_file = open(idx_html_path, "w")

    html_file.write(
        "<!DOCTYPE html>\n<html>\n<style>\ntable, th, td \
    {\n\tborder:1px solid black;\n}\n</style>\n<body>\n\n<h2>BFASST \
     Experiment Runs and Results</h2>\n"
    )

    html_file.write("\n" + html_str)

    html_file.write(
        '\n\n<p>To run these designs yourself, check out \
     the <a href="https://github.com/byuccl/bfasst">BFASST Github \
      repository</a>.</p>\n\n</body>\n</html>'
    )

    html_file.close()


def html_update(equivalence, design, flow_fcn, flows_list):
    """This function updates the html table. It converts
    the experiments that output equivalent to table entries
    of yes and not equivanlent experiments to tabke entries
    of no."""

    idx_html_path = "./index.html"

    if str(equivalence).find("Equivalent") != -1:
        table_value = "Yes"
    elif str(equivalence).find("Not equivalent") != -1:
        table_value = "No"
    else:
        table_value = str(equivalence)

    flow_name = flow_fcn.split()
    curr_flow = flow_name[1][5:]

    flow_dict = dict.fromkeys(flows_list, "Not Run Yet")
    for flow in flows_list:
        if flow == curr_flow:
            flow_dict[flow] = table_value

    chk_html(idx_html_path, flows_list)
    with open(idx_html_path, "r") as fp:
        html = fp.read()

    x = from_html_one(html)
    x_json = json.loads(x.get_json_string())

    if design in x.get_json_string():
        for i, curr_x_json in enumerate(x_json):
            # curr_x_json = x_json[i]
            if design in str(curr_x_json):
                if (
                    curr_x_json[curr_flow] != flow_dict[curr_flow]
                    and flow_dict[curr_flow] != "Not Run Yet"
                ):
                    curr_x_json[curr_flow] = flow_dict[curr_flow]
                for f in flows_list:
                    if f != curr_flow:
                        flow_dict[f] = curr_x_json[f]
                x.del_row(i - 1)
                break

    temp_list = [flow_dict[column] for column in flows_list]
    temp_list.insert(0, design)
    x.add_row(temp_list)

    write_html(x.get_html_string(), idx_html_path)


def list_maker(flows_list, design_dict=None, go_make=False):
    """This function makes a list of each experiment
    with the design being tested, the result of the experiment,
    and the flow used."""

    if design_dict is None:
        design_dict = {}
    idx_html_path = "./index.html"
    if design_dict != {}:
        file1 = open("temp.txt", "a+")  # append mode
        json.dump(design_dict, file1)
        file1.write("\n")
        file1.close()
    if go_make:
        try:
            file1 = open("temp.txt", "r")
            line = file1.readline()
            while line:
                json_temp = json.loads(line)
                line = file1.readline()
                html_update(
                    json_temp["status"], json_temp["design"], json_temp["flow_fcn"], flows_list
                )
            file1.close()
            pathlib.Path("./temp.txt").unlink()
            print("index.html updated")  # Updated
        except:
            chk_html(idx_html_path, flows_list)
            print("index.html unchanged")  # Do nothing


def run_design(print_lock, running_list, design, work_path, flow_fcn, flow_args):
    """This function runs a single job, running the selected CAD flow for one design"""

    enable_proxy()  # Enable STDOUT redirects

    running_list[design.rel_path] = datetime.datetime.now()
    with print_lock:
        print_running_list(running_list)

    buf = redirect()
    try:
        status = flow_fcn(design=design, build_dir=work_path, flow_args=flow_args)
    except BfasstException as e:
        status = Status(status=e.error, msg=str(e), raise_excep=False)
    finally:
        with open(work_path / LOG_FILE_NAME, "w") as f:
            buf.seek(0)
            copyfileobj(buf, f)
        cleanup_redirect()
        path = design_dir
        design_dict = {
            "design": path.name,
            "status": str(status),
            "flow_fcn": str(flow_fcn).casefold(),
        }
        design_dict_copy = design_dict.copy()
        list_maker(flows_list, design_dict=design_dict_copy)
    return (design, status)


def job_done(experiment, print_lock, running_list, design, work_path, statuses, future):
    """Removes job from the running_list, prints the job completion status,
    and saves the return status."""

    ljust = experiment.get_longest_design_name() + 5

    with print_lock:
        if future.exception():
            status = future.exception()

            with open(work_path / LOG_FILE_NAME, "a") as f:
                traceback.print_exception(status, value=status, tb=status.__traceback__, file=f)
        else:
            status = future.result()[1]

        sys.stdout.write("\r\033[K")
        # sys.stdout.write("\033[u")
        sys.stdout.write(str(design.rel_path).ljust(ljust))
        sys.stdout.flush()
        sys.stdout.write(str(status))
        sys.stdout.write("\n")
        # sys.stdout.write("\033[s")

        del running_list[design.rel_path]
        print_running_list(running_list)

    statuses.append(status)


def main(experiment_yaml, num_threads, print_period=1):
    """Setup and run experiment as multiple processes"""
    # os.setpgrp()  # create new process group, become its leader

    # Make sure we capture Ctrl+C
    signal.signal(signal.SIGINT, signal.default_int_handler)

    enable_proxy()  # Enable STDOUT redirects

    # Build experiment object
    experiment = bfasst.experiment.Experiment(experiment_yaml)

    # Don't run with less than one thread
    num_threads = max(1, num_threads)

    statuses = multiprocessing.Manager().list()
    running_list = multiprocessing.Manager().dict()
    print_lock = multiprocessing.Manager().Lock()

    print_color(TermColor.BLUE, "Running", len(experiment.designs), "designs")

    t_start = time.perf_counter()
    sys.stdout.write("\033[s")

    if print_period:
        update_process = multiprocessing.Process(
            target=update_runtimes_thread,
            args=[print_lock, len(experiment.designs), running_list, statuses],
        )
        update_process.start()

    results = []

    # https://github.com/jpype-project/jpype/issues/1024
    with concurrent.futures.ProcessPoolExecutor(
        max_workers=num_threads, mp_context=multiprocessing.get_context("spawn")
    ) as pool:
        for design in experiment.designs:
            design_dir = experiment.work_dir / design.rel_path
            design_dir.mkdir(parents=True, exist_ok=True)

            future = pool.submit(
                run_design,
                print_lock,
                running_list,
                design,
                design_dir,
                experiment.flow_fcn,
                experiment.flow_args,
            )
            future.add_done_callback(
                functools.partial(
                    job_done, experiment, print_lock, running_list, design, design_dir, statuses
                )
            )
            results.append(future)

        try:
            pool.shutdown(wait=True)
        except KeyboardInterrupt:
            os.killpg(0, signal.SIGKILL)  # kill all processes in my group

    if print_period:
        update_process.terminate()
        update_process.join()
    t_end = time.perf_counter()

    if experiment.post_run is not None:
        experiment.post_run(experiment.work_dir)

    print_ending_stats(statuses, t_end - t_start)


def print_ending_stats(statuses, runtime):
    """Print statistics once complete"""
    print_color(TermColor.BLUE, "\nRan", len(statuses), "jobs")
    print("")
    print("-" * 80)
    print("Status By Type")
    print("-" * 80)

    exception_exists = any(isinstance(s, Exception) for s in statuses)
    error_exists = any(isinstance(s, Status) and s.error for s in statuses)

    # Convert exceptions to strings
    statuses = [f"Exception: {str(s).strip()}" if isinstance(s, Exception) else s for s in statuses]

    # Convert statuses to enums
    statuses = [s.status if isinstance(s, Status) else s for s in statuses]

    if statuses:
        status_counts = collections.Counter(statuses)

        pad = min(max(len(str(status)) for status in status_counts) + 10, 80)
        for status, count in status_counts.items():
            print(str(status).strip().ljust(pad), count)

    for i in enumerate(designs_list):
        print(designs_list[i])

    print("-" * 80)
    print("Execution took", round(runtime, 1), "seconds")
    if exception_exists:
        print_color(
            TermColor.YELLOW, "Exception(s) occurred.  See log files for full exception trace."
        )
    if error_exists:
        print_color(TermColor.YELLOW, "Error(s) occurred.")

    if exception_exists or error_exists:
        sys.exit(-1)
    else:
        print("Completed successfully")


if __name__ == "__main__":
    parser = ArgumentParser()
    # Set up command line arguments
    parser.add_argument("experiment_yaml", type=pathlib.Path, help="Experiment yaml file.")
    parser.add_argument("-j", "--threads", type=int, default=1, help="Number of threads")
    parser.add_argument("--print_period", type=int, default=1)
    args = parser.parse_args()
    main(args.experiment_yaml, args.threads, args.print_period)
