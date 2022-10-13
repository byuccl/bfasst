# Coding Standard

This coding standard ensures consistency and efficiency across the project.
Note that this is subject to change and discussion.

+ 100 character line width maximum.
+ All functions and modules longer than 10 lines should have a docstring.
+ Variable names should be snake_case.
+ Class names should be PascalCase.
+ One import per line.
+ Imports from a given source should be contiguous (eg. stdlib, bfasst, etc.).
+ Nested blocks shouldn't go more than 5 deep.
+ Number of branches of execution shouldn't exceed 12.
+ Parens enclosing if-condition only if line is too long.  Note that parens for grouping are ok.
+ Maximum of 15 locals per function.
+ No else after return statement.
+ Run all code through black.
+ For string generation, use f-strings.
+ If a file has a main, the main should take no arguments, parse the argv, and only call another function.
+ If comparing against a singleton object (`True`, `False`, `None`), use `is` instead of `==`, `is not` instead of `!=`.
+ For parsing system parameters, use argparse

# Style hints

Knowing that it can be frustrating to feel that the standards are
arbitrary and make programming less clear, below are some examples of
how to program in a way that makes things more clear, while following
the coding standard.

## Nested blocks

The following constructs create a block in python:
+ `if`/`elif`/`else`
+ `while`
+ `for`
+ `def`
+ `class`
+ `try`/`except`/`finally`
+ `with`

There are 2 principles to help avoiding this issue: the
single-responsibility principle, and encoding control.

### Single-Responsibility Principle

This principle states that a single function or class should only have
one responsibility.  For example, given the following function:
```python
def print_report(data):
    report = {}
    for x in data:
        for d in x:
            report[d.name] = x.value
	for key, value in report:
	    for i in value:
	        print(f"{key}: {value}\t{i}")
```

This function both generates a report, and formats it at the same time.
If either the data to report or the formatting of the report changes,
this function will have to be modified, thus it violates the single
responsibility principle.  In addition, this nested data structure is
processed all at once, with lots of nested information.

This can be refactored as such:
```python
def extract_data(value, nameds, report):
    for named in nameds:
        report[named.name] = value
    return report

def format_value(key, value):
    for index in value:
        print(f"{key}: {value}\t{index}")

def generate_report(data):
    report = {}
    for item in data:
        report = extract_data(item, item.value, report)
    return report

def format_report(report):
    for key, value in report:
        format_value(key_value)

def run_report(data):
    format_report(generate_report(data))
```
Note that the deepest nesting in this code is 2 deep, and each function
has a single responsibility.  This can help break up loops, error
checking, or long if-else chains.

https://en.wikipedia.org/wiki/Single-responsibility_principle

### Encoding Control

Another way to untangle control is to encode it in data.  One example
of this is mapping keywords to actions.  Given the following code:
```python
result = []
for line in lines:
    if line[0] is "sum":
        result.append(line[1] + line[2])
    elif: line[0] is "difference":
        result.append(line[1] - line[2])
    elif: line[0] is "product":
        result.append(line[1] * line[2])
    else
        result.append(errorval)
```

This can be encoded compactly thus:
```python
parser = {"sum": sum_fn,
        "difference": difference_fn,
        "product": product_fn}

result = []
for line in lines
    op = parser.get(line[0], lambda _: errorval)
    result.append(op(line))
```

Those functions could easily have been lambdas, or defined previously,
but we've reduced nesting and made our control flow much simpler.

See Programming with Data and Function Pointers in
http://doc.cat-v.org/bell_labs/pikestyle

## Number of branches

Having too many branches makes it difficult to read the code, as well
as exhaustively test a given piece of code.  Ideally there should be as
few branches as possible in the whole program.  Branches tend to obscure
the relationship between the input and the output of a program.

This issue can arise when writing parsing code or when doing extensive
error-checking, among other things.

When writing parsing code, consider using a parsing library, or
recursive-descent and table-driven parsers if writing your own.

Error-checking code can be made simpler with exception handling, early
returns, or having sanitization functions that ensure inputs are valid.
For example:
```python
def division(x, y):
    if y != 0:
        return x / y
    else:
        return errorval
    return impossible
```
can be changed in the following ways:
```python
def division(x, y):
    return x / y

def sanitize_divide(x, y):
    if y != 0:
        return division(x, y)
    return errorval

def early_divide(x, y):
    if y == 0:
        return erroval
    return x / y

def exception_divide(x, y):
    try:
        division(x, y)
    except ZeroDivisionError:
        dosomethinguseful()
```

These techniques are not necessarily mutually exclusive.  Note that the
primary advantage of the exception handling is being able to handle the
error much further up the call stack, possibly closer to when that input
was computed, rather than being required to handle it where it is used.
It also prevents long chains of checking for errors and returning them.

Note that this has some overlap with the previous concern of nested
blocks.

## Number of locals

A function should be defined mostly in terms of its inputs.  Those inputs
should be named in such a way as to describe what they contain, and so
should not have to be renamed.  If you have too many inputs, likely you
are violating the single-responsibility principle from earlier.

## main function and argparse

In order to keep the main function consistent, we have standardized on
the following interface:
```python
def main():
    parser = argparse.ArgumentParser()

    parser.add_argument('filename', help='file to process')

    parser.add_argument('-j', type=int,
            default=1, help='number of tasks to do in parallel')

    parser.add_argument('-k', type=int,
            required=True, help='a parameter governing the code')

    args = parser.parse_args()
    run_code(args.filename, args.j, args.k)

if __name__ == "__main__":
    main()
```

Note that main's only responsibility is parsing arguments, and then it
calls a publicly available function to do the work.  This allows the
majority of the program to be exposed as a library, while still providing
for a clean way to invoke it from the command line.
