# Create Git Worktrees

Create git worktrees for parallel development: $ARGUMENTS

## Create Worktree for New Branch
If $ARGUMENTS is provided, create a worktree for that branch:
```bash
# Create new branch and worktree
git worktree add ../$(basename $(pwd))-$ARGUMENTS -b $ARGUMENTS

# Or create worktree for existing branch
git worktree add ../$(basename $(pwd))-$ARGUMENTS $ARGUMENTS
```

## Create Worktrees for All Open PRs
If no arguments, create worktrees for all open PRs:
```bash
gh pr list --json headRefName --jq '.[].headRefName' | while read branch; do
  worktree_dir="../$(basename $(pwd))-${branch//\//-}"
  if [ ! -d "$worktree_dir" ]; then
    echo "Creating worktree for $branch at $worktree_dir"
    git worktree add "$worktree_dir" "$branch"
  else
    echo "Worktree for $branch already exists"
  fi
done
```

## List and Cleanup
```bash
# List all worktrees
git worktree list

# Remove unused worktrees
git worktree prune
```

## Benefits
- Work on multiple branches simultaneously
- Run parallel Claude Code sessions
- Isolated development environments
- No need to stash/commit when switching contexts
