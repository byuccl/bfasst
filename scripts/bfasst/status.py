import enum


class SynthStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1


class ImplStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1
    TOO_MANY_LUTS = 2
    TOO_MANY_FF = 3
    TOO_MANY_IO = 4


class BitReverseStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1


class Status():
    def __init__(self, status, msg=None):
        self.error = False

        self.status = status
        if status.value:
            self.error = True

        self.msg = msg

    def __str__(self):
        if self.status == SynthStatus.SUCCESS:
            s = "Synth Success"
        elif self.status == SynthStatus.ERROR:
            s = "Synth Error"
        elif self.status == ImplStatus.SUCCESS:
            s = "Impl Success"
        elif self.status == ImplStatus.ERROR:
            s = "Impl Error"
        elif self.status == ImplStatus.TOO_MANY_FF:
            s = "Too many FFs"
        elif self.status == ImplStatus.TOO_MANY_IO:
            s = "Too many IOs"
        elif self.status == ImplStatus.TOO_MANY_LUTS:
            s = "Too many LUTs"
        elif self.status == BitReverseStatus.SUCCESS:
            s = "Bitstream Reversal Success"
        elif self.status == BitReverseStatus.ERROR:
            s = "Bitstream Reversal Error"
        else:
            print(self.status)
            raise NotImplementedError

        if self.msg is not None:
            s += " (" + self.msg + ")"
        return s
