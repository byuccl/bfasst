import enum


class SynthStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1


class ImplStatus(enum.Enum):
    SUCCESS = 0
    ERROR = 1


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
            return "Synth Success"
        elif self.status == SynthStatus.ERROR:
            return "Synth Error"
        elif self.status == ImplStatus.SUCCESS:
            return "Impl Success"
        elif self.status == ImplStatus.ERROR:
            return "Impl Error"
        elif self.status == BitReverseStatus.SUCCESS:
            return "Bitstream Reversal Success"
        elif self.status == BitReverseStatus.ERROR:
            return "Bitstream Reversal Error"
        raise NotImplementedError
