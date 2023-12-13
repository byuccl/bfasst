import pathlib
import re


def parse_hierarchical_utilization(path):
    assert path.is_file()
    with open(path) as f:
        lines = f.readlines()

    # Find where in the file the utilization data starts
    start_line = None
    for i, line in enumerate(lines):
        if re.match("\d+\. Utilization by Hierarchy", line):
            start_line = i + 4
    assert start_line
    lines = lines[start_line:]

    # Get the column names, excluding the first two which are the
    # instance and module name
    columns = [c.strip() for c in lines[0].strip()[1:-1].split("|")[2:]]

    # Skip the empty lines
    lines = lines[2:]

    utilization_data = {}

    # Iterate through lines of data
    current_path = None
    prev_spaces = None
    for line in lines:
        if line.startswith("+"):
            break
        cols = line.strip()[1:-1].split("|")

        # Determine the hierarchy level by counting spaces
        spaces = len(cols[0]) - len(cols[0].lstrip())
        if current_path is None:
            assert prev_spaces is None
            current_path = pathlib.Path(cols[0].strip())
        else:
            if spaces > prev_spaces:
                current_path /= cols[0].strip()
            elif spaces == prev_spaces:
                current_path = current_path.parent / cols[0].strip()
            else:
                current_path = current_path.parent.parent / cols[0].strip()
        prev_spaces = spaces

        # Save each column of utilization data
        instance_data = {}
        utilization_data[str(current_path)] = instance_data
        for col, val in zip(columns, cols[2:]):
            instance_data[col] = int(val.strip())

    return utilization_data
