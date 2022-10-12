# Coding Standard

This coding standard ensures consistency and efficiency across the project.
Note that this is subject to change and discussion.

+ 100 character line width maximum.
+ All functions and modules should have a docstring.
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
