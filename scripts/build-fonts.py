#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.10"
# dependencies = ["fonttools[woff]"]
# ///

# regenerate self-hosted fonts in fonts/, subset to used chars

import logging
import subprocess
import sys
import tempfile
import urllib.request
from pathlib import Path

logging.basicConfig(level=logging.INFO, format="%(message)s")
log = logging.getLogger(__name__)

REPO_ROOT = Path(__file__).resolve().parent.parent
FONTS_DIR = REPO_ROOT / "fonts"

GITHUB_RAW = "https://raw.githubusercontent.com/google/fonts/main/ofl"

# safety-margin blocks kept even if unused right now
SAFETY_BLOCKS = [
    (0x0020, 0x007E),  # basic Latin
    (0x00A0, 0x024F),  # Latin-1 Supplement, Latin Extended-A/B
    (0x0250, 0x02FF),  # IPA Extensions, Spacing Modifier Letters
    (0x0300, 0x036F),  # combining diacritics
    (0x0370, 0x03FF),  # Greek and Coptic
    (0x2000, 0x206F),  # general punctuation
    (0x20A0, 0x20CF),  # currency symbols
]

LAYOUT_FEATURES = "*"  # keep all OpenType features


def scan_used_codepoints() -> set[int]:
    codepoints: set[int] = set()
    for path in REPO_ROOT.rglob("*.qmd"):
        if FONTS_DIR in path.parents:
            continue
        text = path.read_text(encoding="utf-8", errors="ignore")
        codepoints.update(ord(c) for c in text if c.isprintable())
    return codepoints


def build_unicode_ranges(codepoints: set[int]) -> str:
    def in_safety_blocks(cp: int) -> bool:
        return any(lo <= cp <= hi for lo, hi in SAFETY_BLOCKS)

    extra = sorted(cp for cp in codepoints if not in_safety_blocks(cp))
    parts = [f"U+{lo:04X}-{hi:04X}" for lo, hi in SAFETY_BLOCKS]
    parts += [f"U+{cp:04X}" for cp in extra]
    if extra:
        log.info("  extra codepoints: " + ", ".join(f"U+{cp:04X} ({chr(cp)!r})" for cp in extra))
    return ",".join(parts)


def fetch(url: str, dest: Path) -> None:
    req = urllib.request.Request(url, headers={"User-Agent": "curl/8"})
    data = urllib.request.urlopen(req).read()
    if data.startswith(b"404:") or data.lstrip().startswith(b"<!DOCTYPE"):
        raise RuntimeError(f"fetch failed for {url}")
    dest.write_bytes(data)


def run(*args: str) -> None:
    subprocess.run(args, check=True)


def instance_variable_font(src: Path, dest: Path, wght: int) -> None:
    run(sys.executable, "-m", "fontTools.varLib.instancer",
        "-q", "-o", str(dest), str(src), f"wght={wght}")


def subset(src: Path, dest: Path, unicode_ranges: str) -> None:
    run(sys.executable, "-m", "fontTools.subset", str(src),
        f"--output-file={dest}",
        "--flavor=woff2",
        f"--unicodes={unicode_ranges}",
        f"--layout-features={LAYOUT_FEATURES}",
        "--no-hinting",
        "--desubroutinize")


def build_family(tmp: Path, unicode_ranges: str, name: str, ofl_dir: str, out_name: str,
                  styles: list[tuple[str, str, int | None]]) -> None:
    # styles: (style_name, filename, weight) -- weight=None means already static
    log.info(f"{name}...")
    out_dir = FONTS_DIR / out_name
    out_dir.mkdir(parents=True, exist_ok=True)

    fetch(f"{GITHUB_RAW}/{ofl_dir}/OFL.txt", out_dir / "OFL.txt")

    fetched: dict[str, Path] = {}
    for style_name, filename, weight in styles:
        if filename not in fetched:
            fetched[filename] = tmp / f"{name}-{filename}"
            fetch(f"{GITHUB_RAW}/{ofl_dir}/{filename}", fetched[filename])
        src = fetched[filename]
        if weight is not None:
            instanced = tmp / f"{name}-{style_name}-{weight}.ttf"
            instance_variable_font(src, instanced, weight)
            src = instanced
        dest = out_dir / f"{name.replace(' ', '')}-{style_name}.woff2"
        subset(src, dest, unicode_ranges)
        log.info(f"  {dest}")


def main() -> None:
    log.info("scanning *.qmd for used chars...")
    unicode_ranges = build_unicode_ranges(scan_used_codepoints())

    with tempfile.TemporaryDirectory() as tmp_str:
        tmp = Path(tmp_str)
        build_family(tmp, unicode_ranges, "EBGaramond", "ebgaramond", "eb-garamond", [
            ("Regular", "EBGaramond%5Bwght%5D.ttf", 400),
            ("Bold", "EBGaramond%5Bwght%5D.ttf", 700),
            ("Italic", "EBGaramond-Italic%5Bwght%5D.ttf", 400),
            ("BoldItalic", "EBGaramond-Italic%5Bwght%5D.ttf", 700),
        ])
        build_family(tmp, unicode_ranges, "IMFellGreatPrimer", "imfellgreatprimer",
                      "im-fell-great-primer", [
                          ("Regular", "IMFeGPrm28P.ttf", None),
                          ("Italic", "IMFeGPit28P.ttf", None),
                      ])
        build_family(tmp, unicode_ranges, "CourierPrime", "courierprime", "courier-prime", [
            ("Regular", "CourierPrime-Regular.ttf", None),
            ("Bold", "CourierPrime-Bold.ttf", None),
            ("Italic", "CourierPrime-Italic.ttf", None),
            ("BoldItalic", "CourierPrime-BoldItalic.ttf", None),
        ])

    log.info("done.")


if __name__ == "__main__":
    main()
