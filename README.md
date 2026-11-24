# Spencer Imbleau's Résumé and Cover Letter

LaTeX source for Spencer Imbleau's résumé and cover letter, with automated builds and deployment via GitHub Actions.

See also [*how I work*](docs/personal-values.md).

[![CI](https://img.shields.io/github/actions/workflow/status/nuzzles/resume/ci.yml?logo=github&label=CI)](https://github.com/nuzzles/resume/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/License-MIT%2FApache--2.0-blue)](#license)

## Deployment

Successful CI builds on `main` publish the documents to [GitHub Pages](https://nuzzles.github.io/resume/). Pull requests and other branches build the PDFs without deploying. To publish manually, run the [CI workflow](https://github.com/nuzzles/resume/actions/workflows/ci.yml) on `main`.

| Document       | View                                                      | Embed                                                         | Download                                                 |
| -------------- | --------------------------------------------------------- | ------------------------------------------------------------- | -------------------------------------------------------- |
| Résumé         | <https://nuzzles.github.io/resume/resume.html>            | <https://nuzzles.github.io/resume/resume-embed.html>          | <https://nuzzles.github.io/resume/resume.pdf>            |
| Cover letter   | <https://nuzzles.github.io/resume/coverletter.html>       | <https://nuzzles.github.io/resume/coverletter-embed.html>     | <https://nuzzles.github.io/resume/coverletter.pdf>       |

## Building Locally

### Prerequisites

- [TeX Live (full)](https://www.tug.org/texlive/) (`brew install texlive`)
- [Make](https://www.gnu.org/software/make/) (`brew install make`)
- Python 3.11 (`brew install python@3.11`)
- [Inkscape](https://inkscape.org/) (`brew install --cask inkscape`)

Install the pinned Python dependencies, including Jinja2 and j2cli, in a virtual environment:

```sh
python3.11 -m venv .venv
source .venv/bin/activate
.venv/bin/python -m pip install -r requirements.txt
```

Activate the environment before running `make`.

### Commands

| Command                        | Description                                                        |
| ------------------------------ | ------------------------------------------------------------------ |
| `make resume`                  | Build the résumé (employed heading)                                |
| `make resume <stem>`           | Build the résumé with the applying heading and a company logo      |
| `make coverletter`             | Build the cover letter (default Blue Origin logo)                  |
| `make coverletter <stem>`      | Build the cover letter with a specific company logo                |
| `make all`                     | Build all documents                                                |
| `make clean`                   | Remove build artifacts                                             |
| `make open`                    | Open generated PDFs                                                |

`<stem>` is the filename stem of a logo in `assets/companies/` (e.g. `make resume spacex`).

## AI Integration

Project guidance lives in [AGENTS.md](AGENTS.md). Shared skills live in [.agents/skills/](.agents/skills/), with [.claude](.claude) symlinked to [.agents](.agents) for Claude Code discovery. Each skill contains its complete workflow.

| Skill | Claude Code | Codex | Description |
| --- | --- | --- | --- |
| [Apply](.agents/skills/apply/SKILL.md) | `/apply` | `$apply` | End-to-end application flow: logo setup, job requirements, résumé tailoring, cover letter writing, builds, and output collection into `applications/<stem>/` |
| [Add company logo](.agents/skills/add-company-logo/SKILL.md) | `/add-company-logo` | `$add-company-logo` | Downloads and checks a company SVG, then exports a tightly cropped PNG into `assets/companies/` |

## Custom Icons

Most icons come from the [`fontawesome5`](https://ctan.org/pkg/fontawesome5?lang=en) TeX package ([documentation](http://mirrors.ctan.org/fonts/fontawesome5/doc/fontawesome5.pdf)). For icons not available in Font Awesome:

1. Find an open-licensed SVG on [SVG Repo](https://www.svgrepo.com)
2. (Optional) Minify with [SVGOMG](https://jakearchibald.github.io/svgomg/)
3. Convert to PNG with tight crop: `inkscape --export-type png -w 1024 -D --export-filename assets/custom-icons/<icon>.png assets/custom-icons/<icon>.svg`

   Alternatively, use [SVGCrop](https://svgcrop.com/).

## Company Logos

The cover letter and heading display a target company's logo. Logos live in [assets/companies/](assets/companies/) and are referenced by filename stem (e.g., `companies/blueorigin` resolves to `blueorigin.png`).

To add a new company logo:

1. Find an open-licensed SVG on [SVG Repo](https://www.svgrepo.com)
2. (Optional) Minify with [SVGOMG](https://jakearchibald.github.io/svgomg/)
3. Save the SVG to `assets/companies/<company>.svg`
4. Convert to PNG with tight crop:

   ```sh
   inkscape --export-type png -h 128 -D --export-filename assets/companies/<company>.png assets/companies/<company>.svg
   ```

   Alternatively, use [SVGCrop](https://svgcrop.com/).

## License

Licensed under either of

- Apache License, Version 2.0
   ([LICENSE-APACHE](LICENSE-APACHE) or <http://www.apache.org/licenses/LICENSE-2.0>)
- MIT license
   ([LICENSE-MIT](LICENSE-MIT) or <http://opensource.org/licenses/MIT>)

at your option

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.
