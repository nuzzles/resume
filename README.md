# 📋 Résumé + Coverletter

A repository containing the LaTeX source of Spencer Imbleau's résumé and coverletter matter. Tested and deployed with GitHub Actions.

---
[![CI](https://img.shields.io/github/actions/workflow/status/nuzzles/resume/ci.yml?logo=github&label=CI)](https://github.com/nuzzles/resume/actions/workflows/ci.yml)
[![Deploy](https://img.shields.io/github/actions/workflow/status/nuzzles/resume/release-latest.yml?logo=github&label=Deploy)](https://github.com/nuzzles/resume/actions/workflows/release-latest.yml)
[![License](https://img.shields.io/github/license/nuzzles/resume?label=License)](./LICENSE)

## 🤖 Deployment

Deployment is automated by [GitHub Actions](https://github.com/nuzzles/resume/actions).

- A manual workflow dispatch deploys the résumé and cover letter to [GitHub Pages](https://nuzzles.github.io/resume/), available in several formats.

  | Artifact               | Link                                                      | Mirror                                        |
  | ---------------------- | --------------------------------------------------------- | --------------------------------------------- |
  | Résumé                 | <https://nuzzles.github.io/resume/resume.html>            | <https://nuzzles.github.io/resume/>           |
  | Résumé, Embedded       | <https://nuzzles.github.io/resume/resume-embed.html>      | <https://nuzzles.github.io/resume/embed.html> |
  | Résumé, Download       | <https://nuzzles.github.io/resume/resume.pdf>             |                                               |
  | Cover letter           | <https://nuzzles.github.io/resume/coverletter.html>       |                                               |
  | Cover letter, Embedded | <https://nuzzles.github.io/resume/coverletter-embed.html> |                                               |
  | Cover letter, Download | <https://nuzzles.github.io/resume/coverletter.pdf>        |                                               |

## 🔧 Building

### Dependencies

- [TeXLive, full](https://www.tug.org/texlive/)
- [Make](https://www.gnu.org/software/make/)
- [j2cli](https://github.com/kolypto/j2cli)

### Commands

- **Build the résumé**:

  ```bash
  make resume
  ```

- **Build the cover letter**:

  ```bash
  make coverletter
  ```

- **Build all**:

  ```bash
  make all
  ```

- **Purge all**:

  ```bash
  make clean
  ```

- **Open PDFs**:

  ```bash
  make open
  ```

## Creating icons

- Most icons come from the [`fontawesome5`](https://ctan.org/pkg/fontawesome5?lang=en) TeX package \[[with documentation](http://mirrors.ctan.org/fonts/fontawesome5/doc/fontawesome5.pdf)\].
- Some are custom made (those not in `fontawesome5`).
  - Find an open-licensed SVG vector on <https://www.svgrepo.com>
  - Ensure whitespace is cropped from the SVG `viewBox`: <https://svgcrop.com/>
  - Minify and strip the resulting SVG: <https://jakearchibald.github.io/svgomg/>
  - Convert svg to png: `inkscape --export-type png -w 1024 --export-filename /path/to/new.png /path/to/my.svg`

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
