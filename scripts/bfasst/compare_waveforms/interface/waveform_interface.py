import yaml


def check_multiple_files(design):
    """A function to check if there are multiple verilog files in a design or not. Used later in parsing stages due to different logic being needed."""
    with open(design.yaml_path, "r") as fp:
        design_props = yaml.safe_load(fp)

    multiple_files = False

    for k in design_props.keys():
        # Handle 'include_all_verilog_files' option
        if k == "include_all_verilog_files":
            multiple_files = True
        # Handle 'include_all_system_verilog_files' option
        elif k == "include_all_system_verilog_files":
            multiple_files = True
    return multiple_files


def user_interface(paths):
    """Handles the actual interface for determining what to do if tests have already been ran.
    Returns 0 if the user wants to end the interface altogether
    Returns 1 if the user wants to re-generate the files
    Returns 2 if the user wants to view the waveforms"""

    # This series of if/else statements is used to check if the tests have already been performed. If they have, an option is presented
    # for the user to view the previously-generated waveforms. If the design was unequivalent previously, the diff output will be
    # pasted into the linux terminal so they can view specific times in the waveform.

    if paths["diff"].exists():
        cont = input(
            "Design has already been tested and came back unequivalent. View Waveforms? Input 1 for yes, 0 for no."
        )
        if cont == "0":
            cont = input(
                "Ok. Do you want to generate new testbenches and check equivalence again? Input 1 for yes, 0 for no."
            )
            if cont == "0":
                print("Ok. Ending Tests.")
                return 0
            return 1
        return 2
    elif paths["vcd"][0].exists() & paths["vcd"][1].exists():
        cont = input(
            "Design has already been tested and was equivalent. View Waveforms? Input 1 for yes, 0 for no."
        )
        if cont == "0":
            cont = input(
                "Ok. Do you want to generate new testbenches and check equivalence again? Input 1 for yes, 0 for no."
            )
            if cont == "0":
                print("Ok. Ending Tests.")
                return 3
            return 1
        return 4
    return 1
