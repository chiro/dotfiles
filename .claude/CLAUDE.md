# Global CLAUDE.md

## Development Process

- **TDD (t-wada style)**: Write a failing test first, make it pass with minimal code, then refactor. Follow the Red-Green-Refactor cycle strictly.
- **Refactoring (Martin Fowler style)**: Refactor in small, safe steps. Each refactoring step should keep tests passing. Separate refactoring commits from behavior-changing commits.
- **Commit granularity**: Commit frequently in small, logical units. Don't let changes accumulate. Each commit should be a coherent, working state.
- **When in doubt, ask**: If instructions or specifications are unclear, do not assume — ask the user for clarification. When multiple interpretations exist, list them explicitly before proceeding.

## Language

- Respond in the same language as the user's message.
