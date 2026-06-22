Run dart analyze on all packages and fix errors:

1. Run `flutter analyze` to identify all analysis issues.
2. For each error found, read the affected file and fix the error.
3. Only fix actual errors — do not fix warnings, infos, or style issues unless they are blocking.
4. After fixing, run `flutter analyze` again to verify all errors are resolved.
5. Run `dart format . --line-length 120` on any files that were modified.
6. Report what was fixed and confirm the analysis is now clean.
