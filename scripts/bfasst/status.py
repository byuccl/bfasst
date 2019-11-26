import enum


class SynthStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1
    TIMEOUT = 2


class ImplStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1
    TOO_MANY_LUTS = 2
    TOO_MANY_FF = 3
    TOO_MANY_IO = 4


class BitReverseStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1

class CompareStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1
    NO_LICENSE = 2
    NOT_EQUIVALENT = 3

msg_map = {
    SynthStatus.SUCCESS: "Synth Success",
    SynthStatus.ERROR: "Synth Error",
    SynthStatus.TIMEOUT: "Synth Timeout",

    ImplStatus.SUCCESS: "Impl Success",
    ImplStatus.ERROR: "Impl Error",
    ImplStatus.TOO_MANY_FF: "Too many FFs",
    ImplStatus.TOO_MANY_LUTS: "Too many LUTs",
    ImplStatus.TOO_MANY_IO: "Too many IOs",

    BitReverseStatus.SUCCESS: "Bitstream Reversal Success",
    BitReverseStatus.ERROR: "Bitstream Reversal Error",

    CompareStatus.SUCCESS: "Equivalent",
    CompareStatus.ERROR: "Compare Error",
    CompareStatus.NO_LICENSE: "No license for comparison tool",
    CompareStatus.NOT_EQUIVALENT: "Not equivalent"
}

class Status():
    def __init__(self, status, msg=None):
        self.error = False

        self.status = status
        if status.value:
            self.error = True

        self.msg = msg

    def __str__(self):
        s = msg_map[self.status]
        if self.msg is not None:
            s += " (" + self.msg + ")"
        return s
