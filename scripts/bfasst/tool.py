import abc

from bfasst.utils import TermColor


class Tool(abc.ABC):
    TERM_COLOR_STAGE = TermColor.PURPLE

    def __init__(self, cwd):
        super().__init__()
        self.cwd = cwd

        self.work_dir = self.make_work_dir()

    @property
    @classmethod
    @abc.abstractclassmethod
    def TOOL_WORK_DIR(self):
        raise NotImplementedError

    def make_work_dir(self):
        work_dir = self.cwd / self.TOOL_WORK_DIR

        if not work_dir.is_dir():
            work_dir.mkdir()
        return work_dir

    def needs_to_run(self, log_file_paths, output_files_and_parser_fcns, py_script_file):
        # Run if a log file is missing
        for log_file_path in log_file_paths:
            if not log_file_path.is_file():
                return True

        # 
        return False

