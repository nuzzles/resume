"""Stage the pinned PDF.js viewer locally for generated HTML previews."""

import base64
import hashlib
import io
from pathlib import Path, PurePosixPath
import sys
import tarfile
from urllib.request import urlopen

VERSION = "6.5.438"
INTEGRITY = "vg8Pw1x+AFKy4AMDvhuWl5cOYV8d698UoEANoFFhc79hqXDnZQqnOXoxw3HG907WHOg1JYOvLhP756boddFxpA=="
FILES = {
    "LICENSE",
    "legacy/build/pdf.mjs",
    "legacy/build/pdf.worker.mjs",
    "legacy/web/pdf_viewer.mjs",
    "legacy/web/pdf_viewer.css",
}
ASSET_DIRS = ("legacy/web/images/", "cmaps/", "standard_fonts/", "wasm/")


def stage(destination):
    marker = destination / ".integrity"
    if marker.exists() and marker.read_text() == INTEGRITY:
        return

    url = f"https://registry.npmjs.org/pdfjs-dist/-/pdfjs-dist-{VERSION}.tgz"
    with urlopen(url, timeout=60) as response:
        archive = response.read()
    digest = base64.b64encode(hashlib.sha512(archive).digest()).decode()
    if digest != INTEGRITY:
        raise ValueError("PDF.js archive integrity check failed")

    copied = set()
    with tarfile.open(fileobj=io.BytesIO(archive), mode="r:gz") as tar:
        for member in tar.getmembers():
            if not member.isfile() or not member.name.startswith("package/"):
                continue
            name = member.name.removeprefix("package/")
            path = PurePosixPath(name)
            if path.is_absolute() or ".." in path.parts:
                raise ValueError("Unsafe PDF.js archive path")
            if name not in FILES and not name.startswith(ASSET_DIRS):
                continue
            target = destination / path
            target.parent.mkdir(parents=True, exist_ok=True)
            with tar.extractfile(member) as source:
                target.write_bytes(source.read())
            copied.add(name)
    if not FILES <= copied:
        raise ValueError("PDF.js archive is missing viewer files")
    marker.write_text(INTEGRITY)
    print(f"Staged PDF.js {VERSION} in {destination}")


if __name__ == "__main__":
    stage(Path(sys.argv[1] if len(sys.argv) > 1 else "pdfjs"))
