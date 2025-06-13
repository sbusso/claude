# Project Setup Memory

## Key Rule: NEVER manually write config files or package.json files

### Backend (Python) Setup
- Use `uv init` to create new Python projects
- Use `uv add` to add dependencies
- Use `uv run` to execute scripts

### Frontend (Node.js/React) Setup  
- Use `bun create` to scaffold new projects (e.g., `bun create react-app`, `bun create vite`)
- Use `bun add` to add dependencies
- Use `bun run` to execute scripts

### What NOT to do:
- ❌ Manually write package.json
- ❌ Manually write pyproject.toml  
- ❌ Manually write vite.config.ts
- ❌ Manually write tsconfig.json

### What TO do:
- ✅ Use package managers' initialization commands
- ✅ Use package managers' add/install commands
- ✅ Let tools generate their own config files
- ✅ Only edit config files if absolutely necessary for specific customization