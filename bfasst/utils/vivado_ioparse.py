"""This module provides support for parsing the report_io output of
vivado into pin-port mappings"""

import sys


def parse_pin(line):
    # Match from report_io file: Pin Number, Signal Name, Use, IO Standard
    res = line.split("|", maxsplit=7)
    if len(res) < 3 or not res[2].strip() or res[2].strip() == "Signal Name" or len(res) < 8:
        return None
    return (res[1].strip(), res[2].strip(), res[5].strip(), res[6].strip().replace("*", ""))


def lines_of(stream):
    yield from stream


# Note that filter with None works like (x for x in gen if x)
def map_pins(io_stream):
    return filter(None, (parse_pin(line) for line in lines_of(io_stream)))


def xdc_line(pin):
    return (
        "set_property -dict "
        f"{{ PACKAGE_PIN {pin[0]}   IOSTANDARD {pin[3]} }} "
        f"[get_ports {{ {pin[1]} }}];\n"
    )


def write_xdc(pinmap, stream):
    for pin in pinmap:
        stream.write(xdc_line(pin))


def main():
    write_xdc(tuple(map_pins(sys.stdin)), sys.stdout)


if __name__ == "__main__":
    main()
