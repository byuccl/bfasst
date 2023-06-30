""" Base class for all tools used in BFASST """

import abc
import argparse
import datetime
import pathlib
import shlex
from shutil import copyfileobj
import subprocess
import sys
import types
from dataclasses import dataclass
from bfasst.output_cntrl import cleanup_redirect, enable_proxy, redirect

from bfasst.utils import TermColor, print_color


class BfasstException(Exception):
    """Base class for all tool exceptions in the bfasst package."""


@dataclass
class ToolProduct:
    """A file product of any tool.  If the tool producesd a log file, then you can also provide
    the log_path, as well as a parser function (check_log_fcn), than can check if a prevoius run of
    the tool was successful or not."""

    file_path: pathlib.Path
    log_path: pathlib.Path = None
    check_log_fcn: types.FunctionType = None


class Tool(abc.ABC):
    """Base class for all tools used in BFASST"""

    TERM_COLOR_STAGE = TermColor.PURPLE

    DATE_FORMAT = "%Y-%m-%d"
    TIME_FORMAT = "%H:%M:%S"
    TIMESTAMP_FORMAT = DATE_FORMAT + " " + TIME_FORMAT + ".%f\t"

    def __init__(self, cwd, design=None):
        super().__init__()
        self.cwd = cwd
        self.design = design
        self.work_dir = self.make_work_dir()
        self.log_path = self.work_dir / "log.txt"

        # Argument parser
        self.arg_parser = None

        # Arguments (after parsing)
        self.args = None

    @property
    @classmethod
    @abc.abstractclassmethod
    def TOOL_WORK_DIR(self):  # pylint: disable=invalid-name
        """The subdirectory in the build folder to used for this tool."""
        raise NotImplementedError

    def remove_logs(self):
        """
        Iterate over the log files that already exist in the work directory and remove them.
        This method need only be called in the constructors of
        child tools that will be used multiple times in a single flow.
        """
        for log in self.work_dir.iterdir():
            if log.is_file():
                log.unlink()

    @abc.abstractmethod
    def add_args(self):
        """Add arguments for argparser.  This should be done using this
        function for all child tool classes."""
        raise NotImplementedError

    def create_arg_parser(self, name, args):
        """Create the arg parser object then add arguments by
        calling child method"""
        self.arg_parser = ToolArgParser(name)

        # Call child function(s) to add arguments to this tool
        self.add_args()

        # Parse the arguments
        self.args = self.arg_parser.parse_args(shlex.split(args))

    def make_work_dir(self):
        work_dir = self.cwd / self.TOOL_WORK_DIR

        if not work_dir.is_dir():
            work_dir.mkdir(parents=True, exist_ok=True)
        return work_dir

    def log_title(self, *msg):
        self.log(f"{'='*80}\n{' '.join(str(s) for s in msg)}\n{'='*80}")

    def log(self, *msg, add_timestamp=False):
        """Write text to the log file and stdout"""
        with open(self.log_path, "a") as log_fp:
            text = " ".join(str(s) for s in msg)
            if add_timestamp:
                time_now = datetime.datetime.now()
                text = time_now.strftime(Tool.TIMESTAMP_FORMAT) + text
            # print(text)
            log_fp.write(f"{text}\n")
            log_fp.flush()

    def need_to_rerun(self, tool_products, dependency_modified_time):
        """Determines whether previous run data can be reused or if the tool needs to be rerun."""

        # Loop through tool prodcuts
        for tool_product in tool_products:
            # If ToolProduct produces a log file:
            if tool_product.log_path:
                # If log file is missing, re-run
                if not tool_product.log_path.is_file():
                    return True

                # If log file is out of date, need to re-run
                if dependency_modified_time > tool_product.log_path.stat().st_mtime:
                    self.log_path.unlink()
                    return True

                # If log file has an error, raise an exception
                status = tool_product.check_log_fcn(tool_product.log_path)
                if status is not None and status.error:
                    raise BfasstException(f"Previous run of tool had an error: {status.msg}")

                # If log file doesn't have an error, but output file is expected and missing, re-run
                if (tool_product.file_path is not None) and (not tool_product.file_path.is_file()):
                    self.log_path.unlink()
                    return True
            else:
                # This ToolProduct doesn't produce a log file

                # Rerun if product file is missing, or if product file is out of date
                if not tool_product.file_path.is_file() or (
                    dependency_modified_time > tool_product.file_path.stat().st_mtime
                ):
                    return True

        # Tool does not need to be rerun
        return False

    def exec_and_log(self, cmd, cwd=None, fp=None, fp_err=None, env=None, timeout=None):
        """Run a command using Popen and log the output, return the process handle"""

        # Default cwd is the work directory
        if cwd is None:
            cwd = self.work_dir

        # Can't provide an fp_err without an fp
        assert fp_err is None or fp is not None

        enable_proxy()
        buf = redirect()
        proc = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT if fp_err is None else subprocess.PIPE,
            universal_newlines=True,
            cwd=cwd,
            env=env,
        )

        with open(self.log_path, "a") as f:
            buf.seek(0)
            copyfileobj(buf, f)
        cleanup_redirect()

        # Print stdout to log
        for line in proc.stdout:
            if fp:
                fp.write(line)
            else:
                self.log(line.strip())

        # If stderr is separate, print it to log as well.
        if fp_err:
            for line in proc.stderr:
                if fp:
                    fp.write(line)
                else:
                    self.log(line.strip())

        proc.communicate(timeout=timeout)
        return proc


class ToolArgParser(argparse.ArgumentParser):
    def __init__(self, name) -> None:
        super().__init__()
        self.name = name

    def error(self, message):
        sys.stderr.write(f"{self.name} args error: {message}\n")
        sys.exit(2)
