You are tasked with creating a comprehensive GitHub issue for feature requests bug reports, or improvement ideas. Your goal is to transform the feature description into a comprehensive GitHub issue that will be added to the project backlog. Focus on product-level requirements and user value, with minimal technical implementation details. Follow best practices and project conventions.

Here is the feature description:
<feature_description>
$ARGUMENTS
</feature_description>

Follow these steps to create the GitHub issue:

1. Research the repository:

   - Visit the provided repo_ur? and examine the repository's structure, existing issues, and documentation.
   - Look for any CONTRIBUTING.md, ISSUE_TEMPLATE.md, or similar files that might contain guidelines for creating issues.
   - Note the project's coding style, naming conventions, and any specific requirements for submitting issues.

2. Research best practices:

   - Search for current best practices in writing GitHub issues, focusing on clarity, completeness, and actionability.
   - Look for examples of well-written issues in popular open-source projects for inspiration.

3. Feature Analysis:

   a. Assess feature complexity by checking for:

   - Cross-system integration requirements
   - New user workflows or paradigms
   - Performance or security implications
   - Multiple stakeholder impacts

   b. Extract core information from the feature description:

   - User Story (Who, What, Why) - focus on the user need and benefit
   - Business Value (Problem solved, User impact, Success metrics)
   - Functional Requirements (what the feature must do)
   - Non-Functional Requirements (performance, security, usability)

   c. Define clear scope boundaries:

   - In Scope: Core functionality, essential user interactions, required integrations
   - Out of Scope: Advanced features for future iterations, edge cases for later consideration, optional enhancements

4. Present a plan:

- Based on your research, outline a plan for creating the Github issue.
- Include the proposed structure of the issue, any label or milestone you plan to use, and how you'll incorporate project-specific conventions.
- Present this plan in <plan> tags.

  ```markdown
  ## User Story

  As a [user type], I want to [capability] so that [benefit].

  ## Problem Statement

  [2-3 sentences describing the problem this feature solves]

  ## Acceptance Criteria

  - [ ] Given [condition], when [action], then [expected result]
  - [ ] Given [condition], when [action], then [expected result]
  - [ ] Given [condition], when [action], then [expected result]

  ## User Experience Requirements

  - [Describe key user interactions]
  - [Specify required user flows]
  - [Define success/error states]

  ## Business Value

  - **Primary Benefit**: [Main value proposition]
  - **Success Metrics**: [How success will be measured]
  - **Impact**: [Who benefits and how]

  ## Functional Requirements

  - [Core capability 1]
  - [Core capability 2]
  - [Core capability 3]

  ## Dependencies

  - [ ] [Dependency 1]
  - [ ] [Dependency 2]

  ## Definition of Done

  - [ ] All acceptance criteria met
  - [ ] User experience flows work end-to-end
  - [ ] Performance requirements satisfied
  - [ ] Security requirements implemented
  - [ ] Accessibility standards met
  - [ ] Documentation updated
  - [ ] Tests cover all acceptance criteria

  ## Technical Notes

  [High-level technical considerations only - implementation details will be planned separately]
  ```

5. Create the GitHub issue:

   - Draft the GitHub issue using the template structure above
   - Include clear title, detailed description, and acceptance criteria
   - Use appropriate formatting (Markdown) for readability
   - Create the issue: `gh issue create --title "[Feature] [brief description]" --body "[content]"`
   - Add to GitHub Project and set appropriate fields

6. Issue validation:

   Review the issue against these criteria:

   - Clear user story with who/what/why
   - Specific and testable acceptance criteria
   - Measurable success criteria and outcomes
   - Clear scope boundaries (in/out of scope)
   - Focused on user value and problem-solving, not implementation details
   - Requirements are specific and clear

   Consider human review if the feature:

   - Affects core user workflows
   - Introduces new user-facing concepts
   - Has high business logic complexity

Your final output should be the completed GitHub issue content, structured according to the template provided in step 2. Do not include any of the explanatory text or steps in your output. Begin your response with the heading "## User Story" and end it with the "## Technical Notes" section. Ensure all sections are filled out based on the feature description provided.
