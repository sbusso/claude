# CLAUDE.md

This file provides context to Claude Code about this project's capabilities and standards.

## Project Purpose

This is a GitHub Issues-based development workflow framework that provides AI instruction commands for systematic software development. All work is tracked through GitHub Issues with automatic linking and PR integration.

## Available Commands

You have access to sophisticated workflow commands:

### Planning Commands
- **PRD Creation**: Create comprehensive Product Requirements Documents with market research
- **Feature Specification**: Create focused technical features with implementation details
- **Task Breakdown**: Break down issues into implementable tasks with dependency management

### Implementation Commands  
- **Task Implementation**: Execute tasks with systematic implementation, testing, and quality validation
- **Project Analysis**: Analyze current project status and provide intelligent next-action suggestions

## Development Standards

### Package Management (Critical Rule: NEVER manually write config files)
- **Python**: Use `uv init` to create projects, `uv add` for dependencies, `uv run` for scripts (never edit pyproject.toml manually)
- **Node.js**: Use `bun create` to scaffold projects, `bun add` for dependencies, `bun run` for scripts (never edit package.json manually)
- **TypeScript**: Strict mode enabled, follow project conventions

### What NOT to do:
- ❌ Manually write package.json, pyproject.toml, vite.config.ts, tsconfig.json
- ❌ Edit configuration files unless absolutely necessary for specific customization

### What TO do:
- ✅ Use package managers' initialization commands (uv init, bun create)
- ✅ Use package managers' add/install commands (uv add, bun add)
- ✅ Let tools generate their own config files

### Code Quality
- **File Size Limit**: Maximum 300 lines per file
- **Testing Strategy**: Test what matters - core business logic and critical user flows
- **Linting**: Always run lint checks before committing
- **Documentation**: Comment complex logic, document breaking changes

### Language-Specific Guidelines
Commands automatically reference these context files for development standards:
- **`.claude/contexts/python.md`** - uv workflows, FastAPI, Pydantic, testing patterns
- **`.claude/contexts/typescript.md`** - bun workflows, TanStack Router, shadcn/ui patterns  
- **`.claude/contexts/react.md`** - React 19, Server Components, modern patterns
- **`.claude/contexts/tailwind.md`** - Utility-first CSS patterns and best practices

## Smart Testing Philosophy

### Test What Matters
- **New features**: Test main happy path + one error case
- **Bug fixes**: Write test that reproduces bug, then fix
- **UI changes**: Quick Playwright test for critical user flows
- **Refactoring**: Existing tests should continue passing

### Skip Tests For
- Trivial getters/setters
- Framework/library code  
- One-off scripts
- Pure UI styling

### Lean TDD Cycle
1. **Write minimal test** for core functionality
2. **Commit failing test**: `git commit -m "test: reproduce issue #X"`
3. **Make it pass** with simplest code
4. **Commit working code**: `git commit -m "feat: fix issue #X"`
5. **Refactor if needed** (only if messy)

## Available Context and Tools

### Language-Specific Context
Commands automatically reference development standards for:
- **Python**: uv workflows, FastAPI patterns, Pydantic validation, testing strategies
- **TypeScript**: bun workflows, TanStack Router, shadcn/ui patterns
- **React**: React 19, Server Components, modern patterns
- **Tailwind**: Utility-first CSS patterns and best practices

### Model Context Protocol Integration
- **GitHub MCP**: Automatically integrated for issue and repository management
- **Context7**: Available for up-to-date documentation (`use context7`)
- **Playwright**: Available for browser automation and testing

## Extended Thinking Integration

For complex scenarios, engage in extended thinking to analyze:
- Technical architecture decisions and integration patterns
- Market positioning and competitive analysis for PRDs
- Implementation challenges and risk mitigation strategies
- Quality validation and human review triggers

## Quality Standards

### Basic Quality Checklist
- [ ] Feature works as expected
- [ ] Tests pass for important functionality  
- [ ] No TypeScript errors
- [ ] Files under 300 lines
- [ ] Code is readable and well-structured

### Documentation Requirements
- [ ] Complex logic has clear comments
- [ ] Breaking changes are documented
- [ ] User-facing changes have clear descriptions
- [ ] API changes include examples

## Development Philosophy

**Move fast, test smart, keep it simple.**

- Focus on building features that solve real problems
- Test the critical paths that would break user workflows
- Use automation to handle repetitive tasks
- Maintain code quality without over-engineering
- Document decisions and changes for team clarity

## Additional Resources

- **Language standards**: Reference `.claude/contexts/` files for language-specific development guidance
- **MCP capabilities**: Use `use context7` for up-to-date documentation, `use playwright` for browser automation