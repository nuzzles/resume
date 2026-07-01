# Add Company Logo

Add a new company logo to `assets/companies/` and wire up the commented-out alternatives in the heading/letter sections.

## What to expect from the user

The user will name a company (e.g. "SpaceX", "NVIDIA", "Google"). They may optionally specify:

- A stem/filename to use (defaults to lowercase company name, no spaces, e.g. `spacex`)
- A color treatment override (otherwise proceed automatically per the rules below)

If the SVG source is not provided, search Wikimedia Commons or ask the user for a URL.

## Steps

1. **Download the SVG** into `assets/companies/<stem>.svg`.
   - Prefer Wikimedia Commons SVGs (open-licensed).
   - Use `curl -sL "<url>" -o assets/companies/<stem>.svg`.

2. **Inspect the SVG colors** — read the file and identify all fill/stroke color values.
   - The resume is black on white. Most logos will render fine as-is (colored logos are acceptable).
   - **Exception — invisible colors**: if any element uses white (`#ffffff`, `rgb(255,255,255)`, etc.) or near-white as a fill or stroke, it will be invisible on the white resume background. In that case, ask the user how they'd like to handle it (e.g. invert to black, outline only, different source logo).
   - If the user explicitly requests a color treatment (e.g. "make it black", "grayscale"), apply it: replace all color values in `fill`, `stroke`, and `style` attributes with `#000000` for black, or the luminance-equivalent grey for grayscale.

3. **Generate the PNG** using Inkscape with tight crop:

   ```sh
   inkscape --export-type png -h 128 -D --export-filename assets/companies/<stem>.png assets/companies/<stem>.svg
   ```

   The `-D` flag (`--export-area-drawing`) crops to the tightest bounding box of the actual drawing content, ignoring any surrounding page/canvas whitespace.

   If Inkscape is not installed, the user has not installed the pre-required dependencies in the README.

4. **Verify the crop** — check that the exported PNG has no significant whitespace padding by inspecting its dimensions:

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
   print(f'Padding — x: {pad_x}px, y: {pad_y}px')
   "
   ```

   If `pad_x` or `pad_y` is large (more than ~4px), the SVG itself likely has built-in whitespace margins. In that case, re-open the SVG in Inkscape, select all objects, and use **File → Document Properties → Resize page to content** (or `inkscape --actions="select-all;fit-page-to-selection" --export-type svg`), then re-export.

5. **Confirm** by listing `assets/companies/` so the user can see both the SVG and PNG are present.

## Notes

- The LaTeX `\includegraphics` call uses the stem without extension — LaTeX resolves to `.png` automatically.
- Always generate the PNG; the SVG alone is not sufficient for LaTeX compilation.
- Color tweaks must be made to the SVG *before* generating the PNG.
