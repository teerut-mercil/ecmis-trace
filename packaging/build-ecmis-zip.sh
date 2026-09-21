#!/usr/bin/env bash
# แพ็ก skill ecmis + ชุดโปรเจกต์ตั้งต้น ecmis-trace + ตัวติดตั้ง เป็นไฟล์ zip เดียว
# ใช้: bash packaging/build-ecmis-zip.sh [โฟลเดอร์ปลายทาง]   (ค่าเริ่มต้น dist/)
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
REPO="$(cd "$HERE/.." && pwd)"
SRC="$REPO/ecmis-trace"
OUT_DIR="${1:-$REPO/dist}"

VERSION="$(date +%Y%m%d)"
if git -C "$REPO" rev-parse --short HEAD >/dev/null 2>&1; then
  VERSION="$VERSION-$(git -C "$REPO" rev-parse --short HEAD)"
fi
NAME="ecmis-skill-$VERSION"

STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
PKG="$STAGE/$NAME"

# skill
mkdir -p "$PKG/skill"
cp -R "$SRC/.claude/skills/ecmis" "$PKG/skill/ecmis"

# ชุดโปรเจกต์ตั้งต้น (ไม่รวมข้อมูลงานใน input/work/output)
P="$PKG/project/ecmis-trace"
mkdir -p "$P/template" "$P/input/docs" "$P/input/code" "$P/work/docs" "$P/work/extract" "$P/output/backup"
cp "$SRC/CLAUDE.md" "$SRC/README.md" "$P/"
cp "$SRC/template/"*.xlsx "$P/template/"
for d in input/docs input/code work/docs work/extract output/backup; do touch "$P/$d/.gitkeep"; done

# ตัวติดตั้ง
cp "$HERE/installer/install.sh" "$HERE/installer/install.ps1" "$HERE/installer/install.cmd" "$HERE/installer/README.txt" "$PKG/"
chmod +x "$PKG/install.sh"
echo "$VERSION" > "$PKG/VERSION"

find "$PKG" \( -name .DS_Store -o -name __pycache__ -o -name '*.pyc' \) -prune -exec rm -rf {} +

mkdir -p "$OUT_DIR"
ZIP="$(cd "$OUT_DIR" && pwd)/$NAME.zip"
rm -f "$ZIP"
(cd "$STAGE" && zip -qr -X "$ZIP" "$NAME")

echo "สร้างไฟล์แล้ว: $ZIP"
