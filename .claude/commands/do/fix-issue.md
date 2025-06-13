# Fix Issue

Find and fix issue #$ARGUMENTS

## Process
1. Fetch issue details: `gh issue view $ARGUMENTS`
2. Create fix branch: `git checkout -b fix/issue-$ARGUMENTS`
3. Analyze the problem and locate relevant code
4. Implement solution with tests
5. Test the fix thoroughly
6. Commit with semantic message
7. Push and create PR

## Implementation Steps
- Read issue description and acceptance criteria
- Locate relevant files in codebase
- Write tests that reproduce the issue
- Implement minimal fix to make tests pass
- Verify fix doesn't break existing functionality
