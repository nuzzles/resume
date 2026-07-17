---
name: add-company-logo
description: Add a company logo to this LaTeX resume repository. Use when the user invokes $add-company-logo or when an application workflow needs matching SVG and PNG files in assets/companies, including downloading or accepting a logo SVG, checking invisible colors, exporting a tight-cropped PNG with Inkscape, and verifying padding.
---

# Add Company Logo

Follow the canonical workflow in `.agent-workflows/add-company-logo.md` from the repository root.

Codex invocation mapping:

- Use this skill when `$apply` needs a missing company logo.
- If an SVG or PNG already exists for the derived stem, continue from the relevant step in the canonical workflow instead of recreating existing assets.
