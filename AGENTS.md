# Resume

LaTeX résumé and cover letter for Spencer Imbleau. Built with XeLaTeX via `make`.

## Build

```sh
make resume              # employed heading (default)
make resume <stem>       # applying heading with company logo
make coverletter         # cover letter, default logo
make coverletter <stem>  # cover letter with company logo
make all                 # both documents
make clean               # remove build artifacts
```

`<stem>` is the filename stem of a logo in `assets/companies/` (e.g. `spacex`). When provided, the resume/coverletter uses `heading_applying` instead of `heading_employed` and substitutes the company logo for the default.

## Project structure

```text
sections/
  heading_employed.tex   # heading for "working at" variant
  heading_applying.tex   # heading for "applying to" variant (blueorigin is the placeholder logo)
  career.tex             # work history
  skills.tex             # competencies table
  projects.tex           # notable projects
  opensource.tex         # open source contributions
  education.tex          # education
  letter.tex             # cover letter body (lorem ipsum placeholder — written fresh per application)

assets/
  companies/             # company logos (SVG + PNG pairs, keyed by stem)
  custom-icons/          # custom PNG icons used in the skills section

applications/            # generated application PDFs (gitignored)
  <stem>/
    resume.pdf
    coverletter.pdf
```

## Cover letter macros

The cover letter uses these custom LaTeX commands (defined in `config/commands.tex`):

- `\opening{Name}` — "Dear Name," salutation
- `\letterparagraph{...}` — body paragraph with standard indent/spacing
- `\closing` — "Sincerely, Spencer Imbleau" + signature image; do not duplicate

## Skills

Available Codex skills (`.agents/skills/`):

- `$apply` - full end-to-end application flow: asks for company, handles logo, reads job req, proposes truthful resume tailoring, writes cover letter, builds both PDFs, deposits them in `applications/<stem>/`, and reverts all edits afterward
- `$add-company-logo` - downloads a company SVG, checks for invisible colors, exports a tight-cropped PNG via Inkscape, and verifies padding

## Important rules

- `sections/letter.tex` is a placeholder. Always restore it to lorem ipsum after generating a cover letter — never commit real letter content.
- Tailoring edits to `sections/career.tex`, `skills.tex`, `projects.tex`, `opensource.tex` should be reverted after the application build unless the user explicitly asks to keep them.
- The Makefile uses temp files (`_resume.tex`, `_coverletter.tex`, `sections/_resume_heading.tex`, etc.) during the build — these are cleaned up automatically and should never be committed.
- Never invent or exaggerate experience when tailoring. Only reorder, reframe, or emphasize what is already present.
