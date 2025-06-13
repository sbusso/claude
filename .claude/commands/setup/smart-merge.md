# Smart Merge Framework Files

Intelligently merge Claude Code framework files with existing project files using semantic analysis.

## Usage

This command is called automatically during installation when conflicts are detected, or manually:

```bash
# In Claude Code REPL
/project:smart-merge <file-type> <existing-file> <framework-file>

# Or using the utility script directly
.claude/utils/smart-merge.sh <file-type> <existing-file> <framework-file>
```

## Merge Strategy

### CLAUDE.md Merging

**Task**: Analyze and merge two CLAUDE.md files while preserving project-specific content and adding framework capabilities.

**Process**:
1. **Read both files** - existing project CLAUDE.md and framework template
2. **Identify sections** - parse headers and content blocks
3. **Preserve project content** - keep all project-specific instructions, workflows, and documentation
4. **Add framework sections** - intelligently integrate workflow commands, testing philosophy, and tool documentation
5. **Resolve conflicts** - merge overlapping sections semantically rather than just appending
6. **Maintain structure** - ensure logical flow and organization

**Framework sections to integrate**:
- Development Workflow (planning and implementation phases)
- Smart Testing Philosophy 
- Available Tools & MCPs
- GitHub Projects Setup
- Command Reference
- Quality Standards

**Preservation priorities**:
1. Project-specific business logic and requirements
2. Existing development standards and conventions  
3. Custom workflow adaptations
4. Team-specific documentation and processes

### .mcp.json Merging

**Task**: Merge MCP server configurations without losing existing custom MCPs.

**Process**:
1. **Parse JSON structures** - load both configurations
2. **Merge server definitions** - combine server objects
3. **Avoid duplicates** - check for existing framework MCPs (context7, playwright, github)
4. **Preserve custom servers** - keep all user-defined MCP servers
5. **Validate structure** - ensure resulting JSON is valid

### Command File Updates

**Task**: Update framework commands while preserving any customizations.

**Process**:
1. **Compare files** - identify actual differences
2. **Preserve customizations** - keep user modifications to argument handling or workflow steps
3. **Update framework sections** - integrate new features and improvements
4. **Maintain compatibility** - ensure $ARGUMENTS and command structure remain consistent

## Implementation

### For CLAUDE.md
```markdown
Analyze these two CLAUDE.md files and create an intelligent merge:

**Existing file**: [existing CLAUDE.md content]
**Framework template**: [framework CLAUDE.md content]

Requirements:
- Preserve all project-specific content and requirements
- Add framework workflow sections where they don't conflict
- Merge overlapping sections intelligently (don't just append)
- Maintain logical document structure and flow
- Keep team-specific conventions and standards
- Add framework capabilities without disrupting existing workflows

Create a merged file that combines the best of both while prioritizing existing project needs.
```

### For .mcp.json
```markdown
Merge these MCP configurations intelligently:

**Existing**: [existing .mcp.json]
**Framework**: [framework .mcp.json]

Requirements:
- Preserve all existing custom MCP servers
- Add framework MCPs (context7, playwright, github) if not already present
- Avoid duplicate server definitions
- Maintain valid JSON structure
- Preserve any custom server configurations or arguments

Output the merged JSON configuration.
```

### For Command Files
```markdown
Compare and merge these command files:

**Existing**: [existing command content]
**Framework**: [framework command content]

Requirements:
- Preserve any user customizations to workflow steps
- Update to latest framework features and improvements
- Maintain $ARGUMENTS compatibility
- Keep any project-specific adaptations
- Ensure command still follows framework patterns

Create an updated command that incorporates framework improvements while preserving customizations.
```

## Error Handling

If merge conflicts are too complex for automatic resolution:

1. **Create backup** of existing file with timestamp
2. **Report conflict** with specific areas that need manual attention
3. **Provide guidance** on how to manually resolve
4. **Suggest review** of both files side-by-side

## Backup Strategy

Before any merge operation:
- Create timestamped backup: `{filename}.backup.{timestamp}`
- Preserve original file until merge is confirmed successful
- Provide rollback instructions if merge is unsatisfactory

## Quality Validation

After merge:
- Validate file syntax (JSON for .mcp.json, Markdown structure for .md files)
- Ensure all framework capabilities are included
- Verify no project-specific content was lost
- Confirm logical document structure and readability