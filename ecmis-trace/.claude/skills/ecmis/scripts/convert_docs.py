#!/usr/bin/env python3
"""แปลงเล่มเอกสารใน input/docs เป็น Markdown ใน work/docs ด้วย markitdown

- PDF  : แยกทีละหน้าแล้วแปลง เพื่อคงเลขหน้า (===== หน้า n / N =====)
- PPTX : คงเลขสไลด์ (===== สไลด์ n / N =====)
- DOCX และอื่น ๆ : แปลงทั้งไฟล์ ไม่มีเลขหน้า ให้อ้างอิงด้วยหัวข้อ
- หน้า/ไฟล์ที่ดึงข้อความไม่ได้ (ภาพสแกน, ไฟล์รูป) ติดป้าย [สแกน — ต้องอ่านจากภาพ]
- หน้า PDF ที่สระ/วรรณยุกต์ไทยหลุดบรรทัด ติดป้าย [ข้อความไทยเพี้ยน — ต้องอ่านจากภาพ]

ไฟล์ที่ไม่เปลี่ยน (เทียบ sha256 ใน work/docs/_manifest.json) จะข้าม เว้นแต่ใช้ --force
ผลสรุปพิมพ์เป็น JSON ทาง stdout

Exit code: 0 = สำเร็จ, 2 = ไม่มีไฟล์ใน input/docs, 3 = ยังไม่ได้ติดตั้งแพ็กเกจที่ต้องใช้
"""
import argparse
import hashlib
import io
import json
import re
import sys
from pathlib import Path

SCAN_TAG = "[สแกน — ต้องอ่านจากภาพ]"
GARBLED_TAG = "[ข้อความไทยเพี้ยน — ต้องอ่านจากภาพ]"
MIN_TEXT_CHARS = 20  # หน้าที่มีตัวอักษร (ไม่นับช่องว่าง) น้อยกว่านี้ ถือว่าเป็นภาพสแกน
IMAGE_EXT = {".png", ".jpg", ".jpeg", ".tif", ".tiff", ".bmp", ".gif", ".webp", ".heic"}
UNSUPPORTED_EXT = {".doc": "บันทึกเป็น .docx ก่อน", ".ppt": "บันทึกเป็น .pptx ก่อน", ".xls": "บันทึกเป็น .xlsx ก่อน"}


def check_deps():
    missing = []
    for mod, pkg in (("markitdown", "markitdown[all]"), ("pypdf", "pypdf")):
        try:
            __import__(mod)
        except ImportError:
            missing.append(pkg)
    return missing


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def text_chars(s: str) -> int:
    return len(re.sub(r"\s", "", s))


# สระบน/ล่างและวรรณยุกต์ไทย — ไม่ควรขึ้นต้นบรรทัด ถ้าเจอแปลว่า pdfminer วางตำแหน่งตัวอักษรเพี้ยน
THAI_MARK_LINE = re.compile(r"^\s*[\u0E31\u0E34-\u0E3A\u0E47-\u0E4E]", re.M)


def normalize_thai(s: str) -> str:
    return s.replace("\u0E4D\u0E32", "\u0E33")  # นิคหิต+สระอา → สระอำ


def thai_garbled(s: str) -> bool:
    return THAI_MARK_LINE.search(s) is not None


def convert_pdf(md, path: Path):
    from pypdf import PdfReader, PdfWriter

    reader = PdfReader(str(path))
    total = len(reader.pages)
    try:
        labels = reader.page_labels
    except Exception:
        labels = []
    parts, scanned, garbled = [], [], []
    for i, page in enumerate(reader.pages, start=1):
        buf = io.BytesIO()
        writer = PdfWriter()
        writer.add_page(page)
        writer.write(buf)
        buf.seek(0)
        try:
            body = normalize_thai(md.convert_stream(buf, file_extension=".pdf").text_content.strip())
        except Exception as e:  # หน้าเสียไม่ควรทำให้ทั้งเล่มล้ม
            body = f"(แปลงหน้านี้ไม่ได้: {e})"
        label = labels[i - 1] if i - 1 < len(labels) else str(i)
        header = f"===== หน้า {i} / {total}"
        if label != str(i):
            header += f" (เลขในเล่ม: {label})"
        header += " ====="
        if text_chars(body) < MIN_TEXT_CHARS:
            header += f" {SCAN_TAG}"
            scanned.append(i)
        elif thai_garbled(body):
            header += f" {GARBLED_TAG}"
            garbled.append(i)
        parts.append(f"{header}\n{body}\n")
    return "\n".join(parts), total, scanned, garbled


def convert_pptx(md, path: Path):
    text = md.convert(str(path)).text_content
    total = len(re.findall(r"<!-- Slide number: \d+ -->", text))
    text = re.sub(
        r"<!-- Slide number: (\d+) -->",
        lambda m: f"===== สไลด์ {m.group(1)} / {total} =====",
        text,
    )
    return text, total


def convert_one(md, path: Path):
    """คืนค่า (markdown, info) — info ใช้ลง manifest และรายงาน"""
    ext = path.suffix.lower()
    info = {"type": ext.lstrip("."), "pages": None, "scanned_pages": [], "garbled_pages": [],
            "needs_vision": False, "ref_style": "หัวข้อ"}
    head = f"# {path.name}\n\n"

    if ext in IMAGE_EXT:
        info["needs_vision"] = True
        return head + f"{SCAN_TAG}\nไฟล์รูปภาพ — อ่านเนื้อหาจาก `input/docs/{path.name}` โดยตรง\n", info

    if ext == ".pdf":
        body, total, scanned, garbled = convert_pdf(md, path)
        info.update(pages=total, scanned_pages=scanned, garbled_pages=garbled, ref_style="เลขหน้า")
        return head + body, info

    if ext == ".pptx":
        body, total = convert_pptx(md, path)
        info.update(pages=total, ref_style="เลขสไลด์")
        return head + body, info

    body = normalize_thai(md.convert(str(path)).text_content.strip())
    note = "> ไฟล์นี้ไม่มีเลขหน้า — อ้างอิงด้วยชื่อหัวข้อ เช่น `ชื่อเล่ม §ชื่อหัวข้อ`\n\n"
    if text_chars(body) < MIN_TEXT_CHARS:
        info["needs_vision"] = True
        body = f"{SCAN_TAG}\n(ดึงข้อความไม่ได้ — อ่านจาก `input/docs/{path.name}` โดยตรง)"
    return head + note + body + "\n", info


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("project_root", help="โฟลเดอร์ ecmis-trace")
    ap.add_argument("--force", action="store_true", help="แปลงใหม่ทุกไฟล์แม้ไม่เปลี่ยน")
    ap.add_argument("--check-deps", action="store_true", help="ตรวจแพ็กเกจอย่างเดียว")
    args = ap.parse_args()

    missing = check_deps()
    if missing:
        print(json.dumps({"status": "missing_deps", "missing": missing, "python": sys.executable}, ensure_ascii=False))
        sys.exit(3)
    if args.check_deps:
        print(json.dumps({"status": "ok", "python": sys.executable}, ensure_ascii=False))
        return

    from markitdown import MarkItDown

    root = Path(args.project_root).resolve()
    src_dir, out_dir = root / "input" / "docs", root / "work" / "docs"
    out_dir.mkdir(parents=True, exist_ok=True)
    manifest_path = out_dir / "_manifest.json"
    manifest = json.loads(manifest_path.read_text("utf-8")) if manifest_path.exists() else {}

    sources = sorted(p for p in src_dir.iterdir() if p.is_file() and not p.name.startswith(".")) if src_dir.exists() else []
    if not sources:
        print(json.dumps({"status": "no_input", "dir": str(src_dir)}, ensure_ascii=False))
        sys.exit(2)

    md = MarkItDown()
    result = {"status": "ok", "converted": [], "skipped": [], "failed": [], "orphaned": []}
    for path in sources:
        ext = path.suffix.lower()
        if ext in UNSUPPORTED_EXT:
            result["failed"].append({"file": path.name, "reason": f"ไม่รองรับ {ext} — {UNSUPPORTED_EXT[ext]}"})
            continue
        digest = sha256(path)
        out_file = out_dir / f"{path.name}.md"
        prev = manifest.get(path.name)
        if not args.force and prev and prev.get("sha256") == digest and out_file.exists():
            result["skipped"].append({"file": path.name, **prev})
            continue
        try:
            text, info = convert_one(md, path)
        except Exception as e:
            result["failed"].append({"file": path.name, "reason": str(e)})
            continue
        out_file.write_text(text, "utf-8")
        info.update(sha256=digest, output=str(out_file.relative_to(root)))
        manifest[path.name] = info
        result["converted"].append({"file": path.name, **info})

    names = {p.name for p in sources}
    for name in list(manifest):
        if name not in names:
            result["orphaned"].append(name)
            out = root / manifest.pop(name).get("output", f"work/docs/{name}.md")
            out.unlink(missing_ok=True)
    manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2), "utf-8")
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
