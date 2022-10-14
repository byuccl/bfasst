""" This module provides support for parsing the report_io output of
vivado into pin-port mappings"""
import re


def parse_pin(line):
    match = re.match(r"\|\s+([A-Z]+[0-9]+)\s+\|\s+([^\s\|]+)\s+\|", line)
    return (match.group(1), match.group(2)) if match else None


def lines_of(filename):
    with open(filename, "r") as linefile:
        for line in linefile:
            yield line


# Note that filter with None works like (x for x in gen if x)
def map_pins(report_io_path):
    return filter(None, (parse_pin(line) for line in lines_of(report_io_path)))
