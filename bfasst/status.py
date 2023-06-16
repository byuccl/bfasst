""" This module contains statuses that the various BFASST tools can return """
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
    COULD_NOT_MAP = 7


class ErrorInjectionStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1
    NO_YAML = 2
    FCN_SUCCESS = 3
    FCN_ERROR = 4


class TransformStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1


class MapStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1


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
    BitReverseStatus.UNSUPPORTED_PRIMITVE: "!! Bit Reverse: Unsupported Primitive",
    CompareStatus.SUCCESS: "Equivalent",
    CompareStatus.ERROR: "!! Compare Error",
    CompareStatus.NO_LICENSE: "No license for comparison tool",
    CompareStatus.NOT_EQUIVALENT: "Not equivalent",
    CompareStatus.TIMEOUT: "!! Compare timeout",
    CompareStatus.PARSE_PROBLEM: "!! Parse error",
    CompareStatus.NEED_TO_RUN_ONESPIN: "Exported to Onespin",
    CompareStatus.COULD_NOT_MAP: "Could not map",
    ErrorInjectionStatus.SUCCESS: "Error Injection Successful",
    ErrorInjectionStatus.ERROR: "Error Injection Unsuccessful",
    ErrorInjectionStatus.NO_YAML: "No YAML for Error Injection",
    ErrorInjectionStatus.FCN_SUCCESS: "FCN Successful",
    ErrorInjectionStatus.FCN_ERROR: "FCN Error",
    TransformStatus.SUCCESS: "Transform Success",
    TransformStatus.ERROR: "Transform Error",
    MapStatus.SUCCESS: "Map Success",
    MapStatus.ERROR: "Map Error",
}


class Status:
    """Represents the status of a BFASST tool after it has run"""

    def __init__(self, status, msg=""):
        self.status = status
        self.msg = msg if msg else ""
        self.error = bool(status.value)

    def __str__(self):
        # If the msg exists and is not in the msg_map, then it is a custom message
        # and should be included in the string representation of the status
        if self.msg not in msg_map[self.status]:
            return f"{msg_map[self.status]}: {self.msg}"
        return msg_map[self.status]
