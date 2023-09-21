# Project Structure

This simple walkthrough explains the architecture of the bfasst project in sufficient detail to allow for understanding how ninja is used, how chevron is used, how to add flows, and how to add tools.

## Ninja

This project uses the ninja build system extensively to build all outputs from any flows. There are two parts to every usage of ninja in the project: a rule, and a build snippet. For example, the rule for vivado is as follows:

```
rule vivado
    command = export tempjou=$$(mktemp); export templog=$$(mktemp); {{ vivado_path }} -mode batch -journal $$tempjou -log $$templog -source $in >&- && mv $$tempjou $journal && mv $$templog $log
    description = vivado $in
```

This rule creates temp files for the vivado log and journal, then launches vivado in batch mode and sources the tcl file from ninja's special `$in` variable, which represents all input dependencies to the rule. It closes stdout, so that the output is only written to the log and journal files. Finally, the rule will move the temp files to the correct location using the provided `$journal` and `$log` paths.

The rule is used by a build snippet. For example, the following build snippet is used to run vivado synthesis (but not implementation!) as part of the `vivado` flow:

```
build {{ synth_output }}/viv_synth.edf {{ synth_output }}/synth.dcp {{#in_context}}{{ synth_output }}/report_io.txt{{/in_context}}: vivado {{ synth_output }}/synth.tcl | {{#verilog}}{{ . }} {{/verilog}} {{#system_verilog}}{{ . }} {{/system_verilog}}
    journal = {{ synth_output }}/vivado.jou
    log = {{ synth_output }}/vivado.log
```

Each ninja build snippet begins with the `build` keyword, lists all outputs that will be created by invoking the rule that is used, invokes the rule using its name (in this case "vivado"), and then lists all inputs that should appear as part of the `$in` variable. The `|` character is used to separate input dependencies that should appear in the `$in` variable from those that should not. In this case, the vivado rule needs the tcl file in the `$in` variable. It does not need the HDL source files in the `$in` variable, but is still dependent on them and should rebuild if they change.

There is special mustache syntax in the above example that is used for string templating. This will be covered in the section entitled [Chevron](#chevron).

Also, notice that the journal and log paths are defined in the build snippet on an indented level from the main body of the build snippet and are passed to the rule. In this case, the rule will use these variables to move the temp files to the correct location.

## How Are Ninja Templates Used?

Ninja templates reside in the ninja_tools subdirectory for the tool that is associated with them. For example, the vivado ninja rule templates are in `ninja_tools/vivado`. RULE SNIPPETS SHOULD BE PLACED IN A SEPARATE FILE FROM BUILD SNIPPETS to maintain the single responsibility principle for tool methods. For example, the build snippet template for vivado synthesis is in `ninja_tools/synth/viv_synth.ninja.mustache` and the snippet that invokes the same rule for implementation is in `ninja_tools/impl/viv_impl.ninja_build.mustache`. Neither of these files contain ninja rules.

The `Flow` objects in bfasst are all responsible for invoking any `Tool` objects that are required for the flow to run and telling them to create their rule and build snippets. The `Tool` objects are responsible for filling in any mustache syntax for its associated rule and build snippets and appending them to the master `build.ninja` file. The `Flow` objects are instantiated automatically by the `FlowManager` object when the `bfasster.py` script is run. There is one flow object for each design that will be included in a given run. All Flow and Tool objects are garbage collected after they have added their rule and build snippets to the `build.ninja` file, and then the `bfasster.py` script runs ninja on the `build.ninja` file.

## Chevron

Chevron is a python library that is used to fill in mustache syntax in the ninja templates. The syntax is as follows:
```
{{ variable_name }}
```
The variable name is the name of a variable that is passed to the chevron template. For example, the following python code will fill in the mustache syntax in the template with the values of the variables that are passed to the template:

```py
import chevron
template = "This is a template with a {{ variable_name }}"
variables = {"variable_name": "value"}
my_str = chevron.render(template, variables)
# my_str = "This is a template with a value"
```

There is also special syntax for templating in lists. For example, the following template will print out all of the values in the list:

```
{{#list_name}}
    {{ . }}
{{/list_name}}
```

The `{{#list_name}}` syntax indicates the beginning of a list. The `{{/list_name}}` syntax indicates the end of a list. The `{{ . }}` syntax indicates the current value in the list. For example, the following python code will fill in the mustache syntax in the template with the values of the variables that are passed to the template:

```py
import chevron
template = "This is a template with a list: {{#list_name}}\n    {{ . }}\n{{/list_name}}"
variables = {"list_name": ["value1", "value2"]}
my_str = chevron.render(template, variables)
# my_str = "This is a template with a list: \n    value1\n    value2\n"
```

Lists are useful as conditionals in templates, because if `False` is passed as the value of a chevron templated list or no value is provided, the list will not render. For example, the following python code will fill in the mustache syntax in the template with the values of the variables that are passed to the template:

```py
import chevron
template = "This is a template with a list: {{#list_name}}\n    {{ . }}\n{{/list_name}}"
variables = {"list_name": False}
my_str = chevron.render(template, variables)
# my_str = "This is a template with a list: "
```

Certain scenarios in flows may warrant the use of chevron lists as conditionals. For example, reading different types of HDL into vivado and determining between ooc and in-context runs is done using chevron lists as conditionals in the tcl templates of this project (see, for example, `ninja_tools/synth/synth.tcl.mustache`).

Finally, if you need ninja to template in a mustache file for you, you can use the `template` rule that already exists in `master.ninja.mustache`. This invokes chevron as a command line utility. It takes a json file with all of your chevron variables, and the template to fill in. *When this is the case, your ninja_tools MUST create the json file that will be used to fill in the template* This approach is commonly used in templating in tcl files as part of your flow. See `ninja_tools/synth/synth.ninja.mustache` for an example of how this style of templating is done, and `ninja_tools/vivado/vivado.py` for an example of how the associated json file is created.

## Adding a New Flow

The following steps should be taken to add a new flow to the project:

1. Create any stand-alone python utility scripts in the `ninja_utils` directory. This may or may not be necessary. For example, physical netlist generation is a `ninja_util` but the `vivado` flow only uses tcl scripts and therefore does not require any `ninja_utils`.

1. Create a file for any new ninja rules and one for all new ninja build snippets in the correct `ninja_tools` sub-directory. Many rules already exist in the project, such as a rule for invoking vivado or filling in mustache files, so in those cases you only need to create build snippet files that will invoke those rules.

1. Create a new python script that is associated with the new ninja rule and build snippets you have created. It will be responsible for filling in the templated rule/build snippets, creating any json files necessary to do so, and appending the rule/build snippets to the master `build.ninja` file. See `ninja_tools/vivado/vivado.py` for an example of how this is done. This new tool object should inherit from the `Tool` class in `ninja_tools/tool.py`.

1. Create a new python script that invokes all tools necessary to run your flow in the `ninja_flows` directory. This new flow object should inherit from the `Flow` class in `ninja_flows/flow.py`. It should create any `Tool` objects that are necessary for the flow to run, and then call the `create_rule` and `create_build_snippet` methods of each `Tool` object. This `Flow` class is also required to have a method that returns the path to itself.

1. Add a unit test file for your new flow to the `test/flows` directory and add your flow to the unit tests for the `test/scripts/test_ninja_flow_manager.py` file.

## add_ninja_deps Method

Each `Flow` and `Tool` object is required to implement the `add_ninja_deps` method. This method should return all src files associated with the object that, if changed, should cause `build.ninja` to *rebuild itself*. We provide a `configure` rule that will rebuild `build.ninja` when these files change. If none of these dependencies change, and the flow and designs stay the same, then `build.ninja` will not be rebuild the next time `bfasster.py` is run. The `add_ninja_deps` method should in every case return a list of paths as strings to all dependency files associated with the object. For example, the `Flow` object for the `vivado` flow is as follows:

```py
def add_ninja_deps(self, deps=None):
        if not deps:
            deps = []
        deps.extend(self.vivado_tool.add_ninja_deps())
        deps.append(f"{NINJA_FLOWS_PATH}/vivado.py ")
        if self.ooc:
            deps.append(f"{NINJA_FLOWS_PATH}/vivado_ooc.py ")
        return deps
```

The entire goal of this restructuring of bfasst is to separate responsibilities and reduce the size of the code base. We hope that our approach will allow new flows to be added with relative ease and greatly improve the maintainability of the code base.