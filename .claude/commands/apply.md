# Apply

End-to-end interactive flow for generating a tailored resume and cover letter for a job application.

## Flow

### Step 1 — Company

Ask the user: **"What company are you applying to?"**

Derive a lowercase, no-spaces filename stem (e.g. "Blue Origin" → `blueorigin`, "SpaceX" → `spacex`).

### Step 2 — Company logo

Run the `/add-company-logo` skill for the company. Pass the company name and stem you derived.

### Step 3 — Job req

Ask the user: **"Paste the job description, or share a URL."**

- If a URL is given, fetch its contents.
- Read the job req carefully: identify required skills, preferred qualifications, keywords, and the role's core responsibilities.

Then read the current resume sections to understand what's present:

- `sections/career.tex`
- `sections/skills.tex`
- `sections/projects.tex`
- `sections/opensource.tex`

Cross-reference the job req against the resume. Identify **truthful tailoring opportunities** — existing experience or wording that could be reordered, emphasized, or reframed to better match the req. Do not invent or exaggerate anything.

Present your findings to the user as a short numbered list:
> "Here are X ways I can tailor the resume to better match this req — all based on what's already there:"

For each suggestion, state what you'd change and why. Ask: **"Which of these would you like me to apply? Or let me know of any others."**

Apply the approved changes directly to the relevant `.tex` section files.

If you have questions about the user's experience that would help tailor the resume more accurately, ask them now before building.

### Step 4 — Build resume

```sh
make resume <stem>
```

### Step 5 — Cover letter

Tell the user: **"Now let's write the cover letter."**

Ask the following (can be asked together):

1. **"Who should I address it to?** (hiring manager name, or 'Hiring Team' if unknown)"
2. **"What are the 2–3 most important things you want the letter to convey?"**
3. **"Is there anything specific about this role or company you're excited about that should come through?"**

Using the answers, the job req, and the resume content, write a complete, genuine cover letter. Write it directly into `sections/letter.tex`, replacing the lorem ipsum content. Use the existing LaTeX macros:

- `\opening{<addressee>}` — salutation
- `\letterparagraph{...}` — one call per paragraph (2–3 paragraphs is standard)
- `\closing` — already handles sign-off, do not duplicate it

Keep the tone professional but personal. The letter should feel like Spencer wrote it, not a template.

Show the user the written letter text (not the raw LaTeX) and ask: **"Does this look good, or would you like any changes?"**

Revise until approved.

### Step 6 — Build cover letter

```sh
make coverletter <stem>
```

### Step 7 — Collect outputs

```sh
mkdir -p applications/<stem>
cp resume.pdf applications/<stem>/resume.pdf
cp coverletter.pdf applications/<stem>/coverletter.pdf
```

Confirm: **"Done. Your application files are in `applications/<stem>/`."**

## Notes

- Always revert `sections/letter.tex` content back to lorem ipsum placeholder after copying the output, so the repo stays in a clean state for the next application.
- If the company logo already exists in `assets/companies/`, skip Step 2 and tell the user.
- Tailoring changes to `.tex` sections should be reverted after the build if the user wants to keep the base resume clean. Ask: **"Should I revert the resume tailoring, or keep those edits?"**
