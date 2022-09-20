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
    ErrorInjectionStatus.SUCCESS : "Error Injection Successful",
    ErrorInjectionStatus.ERROR : "Error Injection Unsuccessful",
    ErrorInjectionStatus.NO_YAML : "No YAML for Error Injection",
    ErrorInjectionStatus.FCN_SUCCESS : "FCN Successful",
    ErrorInjectionStatus.FCN_ERROR : "FCN Error",    
}

class BfasstException(Exception):
    def __init__(self, err, msg):
        super().__init__(msg)
        self.error = err


class Status:
    def __init__(self, status, msg="", raise_excep=True):
        self.status = status
        self.msg = f" ({msg})" if msg else ""
        self.error = True if status.value else False
        if status.value and raise_excep:
            raise BfasstException(status, f"{msg_map[status]}{self.msg}")

    def __str__(self):
        return f"{msg_map[self.status]}{self.msg}"
