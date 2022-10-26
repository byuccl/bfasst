"""The actual user interface for choosing what functions to use."""
import yaml

QUIT_UNEQUIVALENT = 0
RUN_TESTS = 1
CHECK_GRAPHS_UNEQUIVALENT = 2
QUIT_EQUIVALENT = 3
CHECK_GRAPHS_EQUIVALENT = 4

DEFAULT_MESSAGE_1 = "Design has already been tested and was"
DEFAULT_MESSAGE_2 = ". View Waveforms?"
INPUT_RESPONSE = "Input 1 for yes, 0 for no."
GENERATE_TB="Ok. Do you want to generate new testbenches and check equivalence again?"
END_TESTS="Ok. Ending Tests."

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

    """Handles the actual interface for determining what to do if tests have already been ran."""

    if paths["diff"].exists():
        cont = input(
            f"{DEFAULT_MESSAGE_1} unequivalent{DEFAULT_MESSAGE_2} {INPUT_RESPONSE}"
        )
        if cont == "0":
            cont = input(
                f"{GENERATE_TB} {INPUT_RESPONSE}"
            )
            if cont == "0":
                print(END_TESTS)
                return QUIT_UNEQUIVALENT
            return RUN_TESTS
        return CHECK_GRAPHS_UNEQUIVALENT
    elif paths["vcd"][0].exists() & paths["vcd"][1].exists():
        cont = input(
            f"{DEFAULT_MESSAGE_1} equivalent{DEFAULT_MESSAGE_2}"
        )
        if cont == "0":
            cont = input(
                f"{GENERATE_TB} {INPUT_RESPONSE}"
            )
            if cont == "0":
                print(END_TESTS)
                return QUIT_EQUIVALENT
            return RUN_TESTS
        return CHECK_GRAPHS_EQUIVALENT
    return RUN_TESTS
