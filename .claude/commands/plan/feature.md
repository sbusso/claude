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

3. Deep Feature Analysis:
   a. Determine if this is a complex feature by checking for:

   - Cross-system integration requirements
   - New user workflows or paradigms
   - Performance or security implications
   - Multiple stakeholder impacts
   - Unclear technical feasibility
     b. If it's a complex feature, use this extended thinking prompt:
     "Think deeply about this feature request: $ARGUMENTS. Consider the user problem, potential solutions, technical implications, and business value. Think harder about edge cases and integration challenges."
     c. Extract the following from the feature description and your analysis:
   - User Story (Who, What, Why)
   - Business Value (Problem solved, User impact, Success metrics)
   - Functional Requirements
   - Non-Functional Requirements
     d. Define the scope:
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

  ## Non-Functional Requirements

  - **Performance**: [Speed/efficiency expectations]
  - **Security**: [Security considerations]
  - **Accessibility**: [Accessibility requirements]
  - **Scalability**: [Growth considerations]

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

4. Create the GitHub issue:

   - Once the plan is approved, draft the GitHub issue content.
   - Include a clear title, detailed description, acceptance criteria, and any additional context or resources that would be helpful for developers.
   - Use appropriate formatting (e.g., Markdown) to enhance readability.
   - Ensure required labels exist: Run `~/.claude/commands/setup-labels.sh` if needed
   - Create the issue in the backlog using the `gh` command-line tool  
   - Add the issue to the GitHub Project and set appropriate fields

5. Issue Validation:
   a. Review the issue content against this checklist:

   - Clear user story with who/what/why
   - Specific acceptance criteria
   - Measurable success criteria
   - Clear scope boundaries
   - Focused on user value, not implementation
   - Acceptance criteria are testable
   - Requirements are specific and clear
   - Success metrics are measurable
     b. Determine if human review is required based on these criteria:
   - Feature affects core user workflows
   - New user-facing concepts introduced
   - Business logic complexity is high
   - Cross-team coordination needed
   - Significant user behavior changes

6. Best Practices:
   Ensure the issue adheres to these best practices:
   - Focus on user value over technical complexity
   - Provide clear acceptance criteria over implementation details
   - Include measurable outcomes over feature lists
   - Emphasize problem-solving over solution-building
   - Avoid common mistakes like including implementation details or having vague acceptance criteria
   - Maintain quality standards: testable acceptance criteria, measurable success metrics, clear user story, and achievable scope

Your final output should be the completed GitHub issue content, structured according to the template provided in step 2. Do not include any of the explanatory text or steps in your output. Begin your response with the heading "## User Story" and end it with the "## Technical Notes" section. Ensure all sections are filled out based on the feature description provided.
