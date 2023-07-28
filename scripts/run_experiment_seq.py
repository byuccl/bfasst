from argparse import ArgumentParser
import pathlib
import time
import traceback
from bfasst.experiment import Experiment
from bfasst.tool import BfasstException


def cleanup(curr_job, jobs):
    jobs.remove(curr_job)
    for job in jobs:
        job.dependencies.discard(curr_job.uuid)


def main(experiment_yaml):
    experiment = Experiment(experiment_yaml)
    for flow in experiment.flows:
        jobs = flow.create()

        t_start = time.perf_counter()
        try:
            while jobs:
                for job in jobs:
                    if not job.dependencies:
                        job.function()
                        cleanup(job, jobs)
        except BfasstException as e:
            print(e)
        except AssertionError:
            formatted_lines = traceback.format_exc().splitlines()
            line = ""
            for line in reversed(formatted_lines):
                if line.strip().startswith("File"):
                    break
            print(f"AssertionErrror: {line}")
        finally:
            t_end = time.perf_counter()

        runtime = t_end - t_start
        print(f'"{flow.design.path.name}": {round(runtime, 1)}')


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("experiment_yaml", type=pathlib.Path, help="Experiment yaml file.")
    args = parser.parse_args()
    main(args.experiment_yaml)
