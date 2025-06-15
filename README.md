# Claude Code GitHub Workflow System

A powerful, AI-driven development workflow system for Claude Code. **Copy the `.claude/` directory to any project and get intelligent GitHub Issues-based project management.**

## 🚀 Quick Setup

**Simple copy-and-go setup with GitHub integration:**

1. **Copy** the `.claude/` directory to your project root
2. **Include** the `CLAUDE.md` file for project-specific guidance
3. **Set up** GitHub MCP server with your personal access token
4. **Start using** slash commands immediately

```bash
# 1. Copy the .claude/ directory to your project
cp -r /path/to/this-repo/.claude/ /path/to/your-project/

# 2. Copy the project guidance file
cp /path/to/this-repo/.claude/CLAUDE.md /path/to/your-project/.claude/

# 3. Set up GitHub access (required)
export GITHUB_PERSONAL_ACCESS_TOKEN="your_github_token"

# 4. Start using commands:
# /project:plan:prd "user authentication system"
# /project:plan:feature "dark mode toggle"  
# /project:current
```

## 📋 Core Slash Commands

### **Planning Workflow**
```bash
/project:plan:prd "user authentication system"        # Create comprehensive PRD as GitHub issue
/project:plan:feature "dark mode toggle"              # Create focused feature as GitHub issue
/project:plan:tasks "#123"                            # Break down issue into task issues
```

### **Implementation Workflow**  
```bash
/project:do:task "#124"                               # Implement specific task issue
/project:current                                      # Show project context and active work
```

## 🧠 Context-Aware Intelligence

The system automatically adapts to your project:

### **Project Type Detection**
- **Web Application** (React, Next.js) → UX-focused templates and thinking
- **API Service** (FastAPI, Express) → Endpoint and data model focused
- **CLI Tool** (Go, Rust) → Command design and cross-platform focused
- **SaaS Platform** → Multi-tenancy and scalability focused

### **Smart Templates**
Each project type gets optimized templates:
- **Web Apps**: UX requirements, responsive design, accessibility, performance
- **APIs**: Endpoint specs, data models, authentication, scalability
- **CLI Tools**: Command interface, installation, cross-platform support

### **Intelligent Task Breakdown**
```
Simple features:     1, 2, 3, 4
Complex features:    1, 1.1, 1.2, 2, 2.1, 2.2
Very complex:        1, 1.1, 1.1.1, 1.1.2, 1.2, 2.1.1, 2.1.2
```

## 📁 GitHub Issues Workflow

The system creates and manages GitHub Issues for all work tracking:

### **Issue Types**
- **`[PRD]` Issues** - Comprehensive Product Requirements Documents with market research
- **`[Feature]` Issues** - Focused technical features with implementation details
- **`[Task]` Issues** - Specific implementation tasks linked to parent issues

### **Issue Organization**
```
GitHub Repository Issues:
├── #123 [PRD] User Authentication System          # Parent PRD issue
│   ├── #124 [Task] Backend: OAuth provider research
│   ├── #125 [Task] Backend: API endpoints implementation  
│   ├── #126 [Task] Frontend: Login form component
│   └── #127 [Task] Testing: Authentication flow tests
├── #128 [Feature] Dark Mode Toggle                # Feature issue
│   ├── #129 [Task] Frontend: CSS variables setup
│   ├── #130 [Task] Frontend: Toggle component
│   └── #131 [Task] Frontend: Persistence logic
└── Labels: prd, feature, task, frontend, backend, testing
```

### **Automatic Issue Linking**
- Task issues reference parent issues
- Pull requests automatically close task issues
- Progress tracked through issue status and labels

## 🎯 Complete Workflow Example

```bash
# 1. Create a comprehensive PRD with market research (creates GitHub issue #123)
/project:plan:prd "user authentication and authorization system"

# 2. Break it down into implementable tasks (creates issues #124, #125, #126, #127)
/project:plan:tasks "#123"

# 3. Start implementing tasks
/project:do:task "#124"    # Research OAuth providers
/project:do:task "#125"    # API endpoints implementation

# 4. Check progress and get suggestions
/project:current

# 5. Create focused features for specific capabilities (creates issue #128)
/project:plan:feature "password reset flow"
/project:plan:tasks "#128"
```

## 🔧 Included Features

### **Context-Aware Thinking**
Commands include intelligent thinking prompts:
- **Simple tasks**: Quick, focused analysis
- **Complex features**: Deep architectural thinking
- **PRDs**: Strategic business and technical analysis

### **Project Templates**
Ready-to-use templates for common project types:
- **`templates/web-app/`** - React, Next.js, frontend frameworks
- **`templates/api-service/`** - FastAPI, Express, API development
- **`templates/cli-tool/`** - Command-line applications
- **`templates/saas-platform/`** - Multi-service architectures

### **MCP Integration** 
Pre-configured Model Context Protocol servers:
- **Context7**: Up-to-date documentation for any library
- **Playwright**: Browser automation and testing
- **GitHub**: Repository integration
- **Zen**: Multi-model AI collaboration

### **Context System**
Language-specific development standards:
- **`contexts/python.md`** - Python development guidelines (uv, FastAPI, Pydantic)
- **`contexts/typescript.md`** - TypeScript development guidelines (bun, TanStack Router)
- **`contexts/react.md`** - React development guidelines (React 19, Server Components)
- **`contexts/tailwind.md`** - Tailwind CSS patterns and best practices

## 📊 Benefits

### **GitHub Integration Advantages**
- ✅ **Native issue tracking** - All work tracked in GitHub Issues
- ✅ **Automatic linking** - PRs close issues, tasks link to parents
- ✅ **Team collaboration** - Shared visibility through GitHub
- ✅ **No external tools** - Everything in your existing GitHub workflow
- ✅ **AI-powered** - Sophisticated instruction templates guide development

### **Intelligence Features**
- 🧠 **Context-aware templates** based on detected project type
- 🎯 **Smart task breakdown** with automatic issue creation
- 📈 **Progress tracking** through GitHub issue status
- 🔄 **Workflow continuity** between command executions  
- 💡 **Intelligent suggestions** based on current issue state

## 🛠️ Customization

### **Customize AI Instructions**
Edit command templates in `.claude/commands/` to match your needs:
- Modify thinking prompts for your domain
- Adjust validation criteria for your standards
- Add company-specific requirements

### **Add New Commands**
Create new AI instruction templates by adding `.md` files:
- `.claude/commands/plan/` - Planning instruction templates
- `.claude/commands/do/` - Implementation instruction templates
- `.claude/commands/project/` - Context analysis instruction templates

### **Extend Project Context**
Customize project guidance in `.claude/CLAUDE.md`:
- Add company-specific development standards
- Include custom quality checklists
- Define team-specific workflows

## 🔍 What's Different

### **vs Raw GitHub Issues**
- **AI-guided creation** instead of manual issue writing
- **Intelligent templates** instead of blank issue forms
- **Automatic task breakdown** instead of manual decomposition
- **Context-aware analysis** instead of generic descriptions

### **vs Traditional Project Management**
- **AI instruction templates** instead of rigid workflows
- **GitHub-native tracking** instead of external tools
- **Extended thinking integration** for complex analysis
- **Copy-and-go setup** instead of complex installations

## 📚 Documentation

All documentation is embedded in the framework:
- **Command templates**: Step-by-step AI instructions in `.claude/commands/`
- **Project guidance**: Complete setup guide in `.claude/CLAUDE.md` (automatically loaded by Claude Code)
- **Context standards**: Language-specific guidelines in `.claude/contexts/` (referenced by commands)
- **Project analysis**: Available via `/project:current`

## 🎁 Getting Started

1. **Copy** `.claude/` directory and `CLAUDE.md` to your project
2. **Set up** GitHub access with your personal access token
3. **Try** `/project:current` to see your project context
4. **Create** your first PRD with `/project:plan:prd "your idea"`
5. **Break it down** with `/project:plan:tasks "#123"`
6. **Start building** with `/project:do:task "#124"`

That's it! No complex installation, just copy-and-go GitHub workflow automation with intelligent AI guidance that adapts to your project and technology stack.

## 📄 License

MIT - Use this system in any project, commercial or personal.