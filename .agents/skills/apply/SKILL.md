---
name: apply
description: End-to-end job application workflow for this LaTeX resume repository. Use when the user invokes $apply or asks Codex to prepare a tailored resume and cover letter for a specific job, including company logo handling, job description analysis, truthful resume tailoring, PDF builds, output collection, and cleanup of temporary tailoring/letter edits.
---

# Apply

Follow the canonical workflow in `.agent-workflows/apply.md` from the repository root.

Codex invocation mapping:

- When the workflow says to run the shared Add Company Logo workflow, use `$add-company-logo`.
- Keep resume tailoring edits only when the user explicitly asks to keep them.
- Always restore `sections/letter.tex` after copying generated PDFs.
