---
name: add-company-logo
description: Add a company logo to this LaTeX resume repository. Use when the user invokes $add-company-logo or when an application workflow needs matching SVG and PNG files in assets/companies, including downloading or accepting a logo SVG, checking invisible colors, exporting a tight-cropped PNG with Inkscape, and verifying padding.
---

# Add Company Logo

## Workflow

Use this skill to create a matching SVG and PNG logo pair in `assets/companies/`.

The user may provide a company name, a filename stem, a source URL, or a color treatment. If no stem is provided, derive one from the company name using lowercase letters and no spaces, such as `blueorigin` for "Blue Origin".

### 1. Source The SVG

If `assets/companies/<stem>.svg` already exists, inspect it and continue to PNG generation if needed.

If no SVG exists:

- Prefer an open-licensed SVG source such as Wikimedia Commons.
- If a suitable source is not available, ask the user for a source URL.
- Download the SVG to `assets/companies/<stem>.svg`.

Example:

```sh
curl -sL "<url>" -o assets/companies/<stem>.svg
```

### 2. Inspect Colors

Read the SVG and identify fill, stroke, and inline style color values.

The resume is rendered on a white background. Colored logos are acceptable, but white and near-white fills or strokes may be invisible.

If the SVG uses white or near-white visible elements, ask the user how to handle them, such as converting to black, outlining, or choosing a different source.

If the user requests a color treatment:

- For black, replace applicable `fill`, `stroke`, and style colors with `#000000`.
- For grayscale, convert applicable colors to luminance-equivalent grayscale values.

Apply color edits to the SVG before exporting the PNG.

### 3. Export The PNG

Always generate a PNG. LaTeX uses the stem without extension and resolves to the PNG during compilation.

Use Inkscape with a tight crop:

```sh
inkscape --export-type png -h 128 -D --export-filename assets/companies/<stem>.png assets/companies/<stem>.svg
```

The `-D` flag exports the drawing area rather than the full canvas. If Inkscape is unavailable, tell the user the required dependency is missing.

### 4. Verify The Crop

Check for significant padding:

```sh
python3 -c "
from PIL import Image
img = Image.open('assets/companies/<stem>.png')
print('Size:', img.size)
bbox = img.convert('RGBA').getbbox()
w, h = img.size
print('Content bbox:', bbox)
pad_x = bbox[0] + (w - bbox[2])
pad_y = bbox[1] + (h - bbox[3])
print(f'Padding - x: {pad_x}px, y: {pad_y}px')
"
```

If `pad_x` or `pad_y` is more than about 4 px, the SVG likely has built-in margins. Resize the SVG page to content, then re-export. One command-line option is:

```sh
inkscape --actions="select-all;fit-page-to-selection" --export-type svg --export-filename assets/companies/<stem>.svg assets/companies/<stem>.svg
```

### 5. Confirm

List the resulting files and confirm both exist:

```sh
ls -l assets/companies/<stem>.svg assets/companies/<stem>.png
```
