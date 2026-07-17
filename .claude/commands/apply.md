# Apply

Follow the canonical workflow in `.agent-workflows/apply.md` from the repository root.

Claude invocation mapping:

- When the workflow says to run the shared Add Company Logo workflow, use `/add-company-logo`.
- Keep resume tailoring edits only when the user explicitly asks to keep them.
- Always restore `sections/letter.tex` after copying generated PDFs.
