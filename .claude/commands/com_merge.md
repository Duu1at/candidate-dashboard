Check whether the current branch can be safely merged into main without breaking existing logic:

1. Run `git fetch origin main` to get the latest main.
2. Run `git log origin/main..HEAD --oneline` to list all commits in this branch.
3. Run `git diff origin/main...HEAD --stat` to see which files changed.
4. Run `git merge-tree $(git merge-base origin/main HEAD) origin/main HEAD` or `git merge --no-commit --no-ff origin/main` (dry-run) to check for merge conflicts. If you use the merge approach, abort it afterwards with `git merge --abort`.
5. Run `melos run analyze-check` to ensure no analysis errors.
6. Run `dart format . --line-length 120 --set-exit-if-changed` to verify formatting.
7. Run `melos run unit-test` to ensure all tests pass.
8. Produce a clear report:
   - Merge conflict status (clean or conflicts found, list conflicting files)
   - Analysis status (pass/fail)
   - Format status (pass/fail)
   - Test status (pass/fail)
   - Final verdict: safe to merge or not, with reasons
