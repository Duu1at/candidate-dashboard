Run dart analyze and dart format on the specified location:

If a specific path is provided as argument ($ARGUMENTS), run on that path. Otherwise, run on the entire project.

1. Run `flutter analyze $ARGUMENTS` (or `flutter analyze` if no path specified) to check for issues.
2. If there are auto-fixable issues, run `dart fix --apply $ARGUMENTS` to fix them.
3. Run `dart format $ARGUMENTS --line-length 120` (or `dart format . --line-length 120` if no path specified) to format the code.
4. Report the results: how many files were formatted, any remaining analysis issues.
