# Claude Code Workflow Framework

This file provides workflow context when imported into project CLAUDE.md files.

## Development Workflow

This project uses a streamlined GitHub Projects workflow with Claude Code automation:

### Planning Phase
- **/project:feature** - Create feature GitHub issues with extended thinking analysis
- **/project:breakdown** - Break features into implementable tasks assigned to current iteration
- **/project:implement** - Direct technical implementation planning (skips feature analysis)
- **/project:brainstorm** - Critical thinking brainstorming for problem exploration

### Implementation Phase  
- **/project:do-issue** - Smart test-first development with lean TDD approach
- **/project:commit** - Semantic commits with proper formatting
- **/project:create-pr** - Standardized pull request creation

### GitHub Projects Integration
- **Status Flow**: Todo → In Progress → Done (auto-managed)
- **Iteration Assignment**: Tasks automatically assigned to current iteration
- **Label Management**: Automated workflow labels and status tracking

## Available Commands

### Planning Workflows
```bash
/project:feature "add user authentication system"           # Complex features
/project:implement "add CORS support to API"                # Direct technical tasks
/project:brainstorm "users need better search"              # Problem exploration
/project:breakdown 123                                      # Feature issue #123
```

### Implementation Workflows
```bash
/project:do-issue 124                                       # Implement task #124
/project:commit "implement user login endpoint"             # Semantic commit
/project:create-pr                                          # Create pull request
```

### Shell Aliases
```bash
ccf "feature description"     # feature
ccbd 123                     # breakdown
ccim "tech requirement"      # implement
cci 124                      # do-issue
ccc "message"                # commit
ccpr                         # create-pr
ccb "problem"                # brainstorm
ccsync                       # sync workspace
ccpush                       # push improvements
```

This workflow framework is synchronized from the dotclaude repository and provides consistent project automation across all Claude Code projects.