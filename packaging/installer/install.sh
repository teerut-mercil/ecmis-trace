#!/usr/bin/env bash
# ติดตั้ง skill /ecmis แบบ global (macOS / Linux) ไปที่ ~/.claude/skills/ecmis
# ถ้ามีของเดิมอยู่ จะย้ายไปสำรองที่ ~/.claude/skill-backups/ ก่อนติดตั้งทับ
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
SRC="$HERE/skill/ecmis"
CLAUDE_HOME="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
DEST="$CLAUDE_HOME/skills/ecmis"
BACKUP_ROOT="$CLAUDE_HOME/skill-backups"

if [ ! -f "$SRC/SKILL.md" ]; then
  echo "❌ ไม่พบ skill/ecmis/SKILL.md — กรุณาแตกไฟล์ zip ให้ครบก่อนรัน" >&2
  exit 1
fi

echo "== ติดตั้ง skill /ecmis =="
mkdir -p "$CLAUDE_HOME/skills"
if [ -e "$DEST" ]; then
  mkdir -p "$BACKUP_ROOT"
  BK="$BACKUP_ROOT/ecmis-$(date +%Y%m%d-%H%M%S)"
  mv "$DEST" "$BK"
  echo "• สำรองของเดิมไว้ที่ $BK"
fi
cp -R "$SRC" "$DEST"
find "$DEST" -name .DS_Store -delete 2>/dev/null || true
echo "✅ ติดตั้ง skill แล้วที่ $DEST"

echo
echo "== ตรวจตัวแปลงเอกสาร (Python + markitdown) =="
PY=""
for c in python3 python; do
  if command -v "$c" >/dev/null 2>&1 && "$c" -c 'import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)' 2>/dev/null; then
    PY="$c"; break
  fi
done

if [ -z "$PY" ]; then
  echo "⚠️  ไม่พบ Python 3.10 ขึ้นไป — skill ติดตั้งแล้ว แต่ต้องติดตั้ง Python ก่อนใช้งาน"
  echo "   macOS: ติดตั้งจาก https://www.python.org/downloads/ หรือ 'brew install python'"
  echo "   จากนั้นรัน: python3 -m pip install 'markitdown[all]' pypdf"
else
  CHECK=("$PY" "$DEST/scripts/convert_docs.py" . --check-deps)
  if "${CHECK[@]}" >/dev/null 2>&1; then
    echo "✅ markitdown พร้อมใช้งาน ($PY)"
  else
    echo "• กำลังติดตั้ง markitdown และ pypdf ด้วย $PY ..."
    if "$PY" -m pip install -q --user --upgrade 'markitdown[all]' pypdf \
       || "$PY" -m pip install -q --upgrade 'markitdown[all]' pypdf; then
      :
    fi
    if "${CHECK[@]}" >/dev/null 2>&1; then
      echo "✅ ติดตั้ง markitdown สำเร็จ"
    else
      echo "⚠️  ติดตั้ง markitdown ไม่สำเร็จ — skill ใช้งานได้ และจะเสนอให้ติดตั้งอีกครั้งตอนสั่ง /ecmis"
      echo "   หรือติดตั้งเอง: $PY -m pip install 'markitdown[all]' pypdf"
    fi
  fi
fi

echo
echo "== ขั้นต่อไป =="
echo "1. คัดลอกโฟลเดอร์ project/ecmis-trace ไปไว้ที่ที่ต้องการ"
echo "2. วางเล่มเอกสารใน ecmis-trace/input/docs/"
echo "3. เปิด Claude Code ในโฟลเดอร์ ecmis-trace แล้วสั่ง /ecmis <เลข Activity> เช่น /ecmis 5"
