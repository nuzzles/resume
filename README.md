# Spencer Imbleau's Résumé and Cover Letter

LaTeX source for Spencer Imbleau's résumé and cover letter, with automated builds and deployment via GitHub Actions.

[![CI](https://img.shields.io/github/actions/workflow/status/nuzzles/resume/ci.yml?logo=github&label=CI)](https://github.com/nuzzles/resume/actions/workflows/ci.yml)
[![Deploy](https://img.shields.io/github/actions/workflow/status/nuzzles/resume/release-latest.yml?logo=github&label=Deploy)](https://github.com/nuzzles/resume/actions/workflows/release-latest.yml)
[![License](https://img.shields.io/badge/License-MIT%2FApache--2.0-blue)](#license)

## Deployment

Deployment is triggered manually via [workflow dispatch](https://github.com/nuzzles/resume/actions/workflows/release-latest.yml), which builds the documents and publishes them to [GitHub Pages](https://nuzzles.github.io/resume/).

| Document       | View                                                      | Embed                                                         | Download                                                 |
| -------------- | --------------------------------------------------------- | ------------------------------------------------------------- | -------------------------------------------------------- |
| Résumé         | <https://nuzzles.github.io/resume/resume.html>            | <https://nuzzles.github.io/resume/resume-embed.html>          | <https://nuzzles.github.io/resume/resume.pdf>            |
| Cover letter   | <https://nuzzles.github.io/resume/coverletter.html>       | <https://nuzzles.github.io/resume/coverletter-embed.html>     | <https://nuzzles.github.io/resume/coverletter.pdf>       |

## Building Locally

### Prerequisites

- [TeX Live (full)](https://www.tug.org/texlive/) (`brew install texlive`)
- [Make](https://www.gnu.org/software/make/) (`brew install make`)
- [j2cli](https://github.com/kolypto/j2cli) (`brew install j2cli`)
- [Inkscape](https://inkscape.org/) (`brew install --cask inkscape`)

### Commands

| Command                   | Description                                                   |
| ------------------------- | ------------------------------------------------------------- |
| `make resume`             | Build the résumé (employed heading)                           |
| `make resume <stem>`      | Build the résumé with the applying heading and a company logo |
| `make coverletter`        | Build the cover letter                                        |
| `make all`                | Build all documents                                           |
| `make clean`              | Remove build artifacts                                        |
| `make open`               | Open generated PDFs                                           |

`<stem>` is the filename stem of a logo in `assets/companies/` (e.g. `make resume spacex`).

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
