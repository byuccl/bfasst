"""This module provides support for parsing the report_io output of
vivado into pin-port mappings"""

import re
import sys


def parse_pin(line):
    match = re.match(
        r"\|\s+([A-Z]+[0-9]+)\s+\|\s+([^\s\|]+)\s+\|[^\|]+\|[^\|]+\|\s+([A-Z]+)\s+\|",
        line,
    )
    return (match.group(1), match.group(2), match.group(3)) if match else None


def lines_of(stream):
    yield from stream


# Note that filter with None works like (x for x in gen if x)
def map_pins(io_stream):
    return filter(None, (parse_pin(line) for line in lines_of(io_stream)))


def xdc_line(pin):
    return (
        "set_property -dict "
        f"{{ PACKAGE_PIN {pin[0]}   IOSTANDARD LVCMOS33 }} "
        f"[get_ports {{ {pin[1]} }}];\n"
    )


def write_xdc(pinmap, stream):
    for pin in pinmap:
        stream.write(xdc_line(pin))


def main():
    write_xdc(tuple(map_pins(sys.stdin)), sys.stdout)


if __name__ == "__main__":
    main()
