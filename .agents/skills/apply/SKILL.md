---
name: apply
description: End-to-end job application workflow for this LaTeX resume repository. Use when the user invokes $apply or asks Codex to prepare a tailored resume and cover letter for a specific job, including company logo handling, job description analysis, truthful resume tailoring, PDF builds, output collection under the matching applications directory, and cleanup of temporary tailoring/letter edits.
---

# Apply

## Workflow

Use this skill to build an application package for a job. Keep all tailoring truthful: only reorder, reframe, or emphasize experience already present in the resume. Do not invent or exaggerate.

### 1. Company

Ask: "What company are you applying to?"

Derive a lowercase, no-spaces filename stem from the company name, such as `blueorigin` for "Blue Origin" or `spacex` for "SpaceX".

### 2. Company Logo

Check whether both `assets/companies/<stem>.svg` and `assets/companies/<stem>.png` exist.

- If both exist, skip logo setup and tell the user.
- If either is missing, use `$add-company-logo` for the company and stem before building.

### 3. Job Requirement

Ask: "Paste the job description, or share a URL."

If the user provides a URL, fetch and read the job description. Identify required skills, preferred qualifications, keywords, and core responsibilities.

Read the current resume sections:

- `sections/career.tex`
- `sections/skills.tex`
- `sections/projects.tex`
- `sections/opensource.tex`

Cross-reference the job requirement against the resume and identify truthful tailoring opportunities. Present a short numbered list:

```text
Here are X ways I can tailor the resume to better match this req, all based on what's already there:
```

For each suggestion, state what would change and why. Ask which suggestions to apply. If more information about the user's real experience would make tailoring more accurate, ask before editing.

Before editing, record the original contents of every file that may be changed so they can be restored after the PDFs are copied.

### 4. Build Resume

Apply the approved resume tailoring directly to the relevant `.tex` files, then run:

```sh
make resume <stem>
```

### 5. Cover Letter

Tell the user: "Now let's write the cover letter."

Ask:

1. "Who should I address it to? (hiring manager name, or 'Hiring Team' if unknown)"
2. "What are the 2-3 most important things you want the letter to convey?"
3. "Is there anything specific about this role or company you're excited about that should come through?"

Write a complete cover letter into `sections/letter.tex`, replacing the lorem ipsum placeholder. Use only these macros:

- `\opening{<addressee>}`
- `\letterparagraph{...}` for each body paragraph, usually 2-3 paragraphs
- `\closing`

Do not duplicate the closing text. Keep the tone professional, direct, and personal. Show the user the written letter text, not raw LaTeX, and ask whether changes are needed. Revise until approved.

### 6. Build Cover Letter

Run:

```sh
make coverletter <stem>
```

### 7. Collect Outputs

Run:

```sh
mkdir -p applications/<stem>
cp resume.pdf applications/<stem>/resume.pdf
cp coverletter.pdf applications/<stem>/coverletter.pdf
```

Confirm that the application files are in `applications/<stem>/`.

### 8. Restore The Repository

After copying the PDFs:

- Restore `sections/letter.tex` to the original lorem ipsum placeholder content.
- Restore tailoring edits in `sections/career.tex`, `sections/skills.tex`, `sections/projects.tex`, and `sections/opensource.tex` by default.
- Keep tailoring edits only if the user explicitly asked to keep them.
- Do not commit or keep Makefile temporary files such as `_resume.tex`, `_coverletter.tex`, or `sections/_resume_heading.tex`.
