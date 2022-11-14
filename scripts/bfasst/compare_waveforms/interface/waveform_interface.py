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
GENERATE_TB = "Ok. Do you want to generate new testbenches and check equivalence again?"
END_TESTS = "Ok. Ending Tests."


def check_multiple_files(design):

    """A function to check if there are multiple verilog files in a design or not. Used later in
    parsing stages due to different logic being needed. Assumed true if no design exists."""

    if design is None:
        return True

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


def unequivalent_interface(waveform):
    """Handles if the file was previously unequivalent."""

    if waveform is False:
        cont = input(f"{GENERATE_TB} {INPUT_RESPONSE}")
        if cont == "0":
            print(END_TESTS)
            return QUIT_UNEQUIVALENT
        if cont != "1":
            print(f"Invalid input: {cont}, ending tests.")
            return QUIT_UNEQUIVALENT
        return RUN_TESTS
    return CHECK_GRAPHS_UNEQUIVALENT


def equivalent_interface(waveform):
    """Handles if the file was previously equivalent."""
    if waveform is False:
        cont = input(f"{GENERATE_TB} {INPUT_RESPONSE}")
        if cont == "0":
            print(END_TESTS)
            return QUIT_EQUIVALENT
        if cont != "1":
            print(f"Invalid input: {cont}, ending tests.")
            return QUIT_EQUIVALENT
        return RUN_TESTS
    return CHECK_GRAPHS_EQUIVALENT


def user_interface(paths, waveform, quick):

    """Handles the actual interface for determining what to do if tests have already been ran."""
    if quick:
        return RUN_TESTS
    if paths["diff"].exists():
        return unequivalent_interface(waveform)
    if paths["vcd"][0].exists() & paths["vcd"][1].exists():
        return equivalent_interface(waveform)
    return RUN_TESTS
