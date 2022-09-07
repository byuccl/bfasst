import enum


class SynthStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1
    TIMEOUT = 2


class OptStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1
    TIMEOUT = 2
    MAPPER_ERROR = 3
    COMPILE_ERROR = 4


class ImplStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1
    TOO_MANY_LUTS = 2
    TOO_MANY_FF = 3
    TOO_MANY_IO = 4


class BitReverseStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1
    UNSUPPORTED_PRIMITVE = 2


class CompareStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1
    NO_LICENSE = 2
    NOT_EQUIVALENT = 3
    TIMEOUT = 4
    PARSE_PROBLEM = 5
    NEED_TO_RUN_ONESPIN = 6


class ErrorInjectionStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1
    NO_YAML = 2
    FCN_SUCCESS = 3
    FCN_ERROR = 4


msg_map = {
    SynthStatus.SUCCESS: "Synth Success",
    SynthStatus.ERROR: "!! Synth Error",
    SynthStatus.TIMEOUT: "Synth Timeout",
    OptStatus.SUCCESS: "Opt Success",
    OptStatus.ERROR: "!! Opt Error",
    OptStatus.TIMEOUT: "Opt Timeout",
    OptStatus.MAPPER_ERROR: "Opt Mapper Error",
    OptStatus.COMPILE_ERROR: "Opt Compile Error",
    ImplStatus.SUCCESS: "Impl Success",
    ImplStatus.ERROR: "!! Impl Error",
    ImplStatus.TOO_MANY_FF: "Too many FFs",
    ImplStatus.TOO_MANY_LUTS: "Too many LUTs",
    ImplStatus.TOO_MANY_IO: "Too many IOs",
    BitReverseStatus.SUCCESS: "Bitstream Reversal Success",
    BitReverseStatus.ERROR: "Bitstream Reversal Error",
    BitReverseStatus.UNSUPPORTED_PRIMITVE:"!! Bit Reverse: Unsupported Primitive",
    CompareStatus.SUCCESS: "Equivalent",
    CompareStatus.ERROR: "!! Compare Error",
    CompareStatus.NO_LICENSE: "No license for comparison tool",
    CompareStatus.NOT_EQUIVALENT: "Not equivalent",
    CompareStatus.TIMEOUT: "!! Compare timeout",
    CompareStatus.PARSE_PROBLEM: "!! Parse error",
    CompareStatus.NEED_TO_RUN_ONESPIN: "Exported to Onespin",
}

class BfasstException(Exception):
    pass


class Status:
    def __init__(self, status, msg=None):
        self.status = status
        self.msg = msg
        if status.value:
            raise BfasstException(f"{msg_map[status]} ({msg})")

    def __str__(self):
        s = msg_map[self.status]
        if self.msg is not None:
            s = f"{s} ({self.msg})"
        return s
