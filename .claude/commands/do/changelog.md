# Update Changelog

Add entry to CHANGELOG.md: $ARGUMENTS

## Process
1. Parse arguments: `version change_type message`
2. Check if CHANGELOG.md exists, create if needed
3. Add entry under appropriate version section
4. Format according to Keep a Changelog conventions

## Change Types
- **Added**: for new features
- **Changed**: for changes in existing functionality
- **Fixed**: for bug fixes
- **Removed**: for removed features
- **Security**: for security improvements

## Format Example
```
## [1.1.0] - 2024-01-15
### Added
- New authentication system
### Fixed
- Login button styling issue
```

## Usage
```bash
# Example: /project:changelog "1.2.0 added new user dashboard"
# Will add "New user dashboard" under Added section for version 1.2.0
```
