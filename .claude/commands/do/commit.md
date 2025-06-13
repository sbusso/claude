# Git Commit

Create a semantic commit for staged changes: $ARGUMENTS

## Process
1. Check `git status` and `git diff --staged` to review staged changes
2. Generate commit message using format: `[scope] description`
3. Suggest 3-5 commit message options
4. Wait for user confirmation before committing
5. Execute `git commit -m "selected message"`

## Scope Rules
- Use file directory or functionality as scope
- Common scopes: `[ui]`, `[api]`, `[docs]`, `[config]`, `[claude]`
- Description starts lowercase, concise and clear

## Examples
- `[ui] fix button styling on mobile devices`
- `[api] add user authentication endpoint`
- `[docs] update installation instructions`
