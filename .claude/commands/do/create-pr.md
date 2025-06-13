# Create Pull Request

Create a pull request for: $ARGUMENTS

## Process
1. Check current branch and recent commits with `git log --oneline -5`
2. Push current branch if needed: `git push -u origin <branch-name>`
3. Create PR using `gh pr create` with title and description

## Template
```
## Summary
$ARGUMENTS

## Changes
- [Key change 1]
- [Key change 2]

## Testing
- [How tested]

## Related
Closes #[issue-number]
```

## Command
```bash
gh pr create --title "$ARGUMENTS" --body "[generated description]"
```
