# Step 1 — Prepare docs (convert with markitdown)

Convert all documents in `input/docs` to text in `work/docs`, then summarize which Activities each document covers.

## Scope
- **Never touch any Excel file** (template or output)
- Never modify files in `input/`
- **Convert documents only with `convert_docs.py` (markitdown)** — no other conversion method

## Procedure
1. Run the converter (converts only new/changed files; add `--force` if the user asks to reconvert everything)
   ```
   python3 "<SKILL_DIR>/scripts/convert_docs.py" .
   ```
   (`<SKILL_DIR>` = skill folder as defined in SKILL.md)
   Output is JSON: `converted` / `skipped` / `failed` / `orphaned`; each file has `pages`, `scanned_pages`, `garbled_pages`, `needs_vision`, `ref_style`
   - exit 2 → no files in `input/docs`; stop and tell the user
   - `failed` → tell the user with the reason (e.g. `.doc` must be saved as `.docx` first), then continue with other files
   - If `converted` is empty, there is no `orphaned`, and `work/docs/_index.md` exists → skip to item 4

2. Output files are `work/docs/{original name}.md`
   | Type | Separator | Citation format |
   |---|---|---|
   | PDF | `===== หน้า 12 / 240 =====` (if the printed page number differs from the file page: `===== หน้า 12 / 240 (เลขในเล่ม: 8) =====`) | `ชื่อเล่ม น.12` |
   | PPTX | `===== สไลด์ 3 / 20 =====` | `ชื่อเล่ม สไลด์ 3` |
   | DOCX, XLSX, others | no page numbers, use Markdown headings | `ชื่อเล่ม §ชื่อหัวข้อ` e.g. `คู่มือ.docx §3.2.1 การตรวจสอบ` |

3. **Pages that must be read from images** — do every page in `scanned_pages`, `garbled_pages`, and files with `needs_vision: true`
   - `[สแกน — ต้องอ่านจากภาพ]` = scanned image, no extractable text
   - `[ข้อความไทยเพี้ยน — ต้องอ่านจากภาพ]` = Thai vowels/tone marks displaced by PDF text extraction
   - Open that page from the original in `input/docs/` with Read (PDF: use `pages`; images: open directly) and transcribe the Thai+English text
   - Replace that page's content in the `.md` file with the transcription and change the page header label to `[อ่านจากภาพ]`
   - Always keep the original page separator and page number
   - Unclear characters → write `[?]`. **Never guess**, especially LAW / SDD / Page Code IDs
   - If there are dozens of pages, tell the user the page count before starting since it takes time

4. Create or update `work/docs/_index.md` summarizing each document (update only rows of changed documents, delete rows of documents in `orphaned`), with these Thai column headers:
   | เล่ม | จำนวนหน้า | ชนิด (ข้อความ/สแกน/ผสม) | วิธีอ้างอิง (เลขหน้า/สไลด์/หัวข้อ) | Activity ที่ครอบคลุม (พร้อมช่วงหน้าหรือหัวข้อ) | ตำแหน่งรหัส LAW | ตำแหน่งรหัส SDD | ตำแหน่ง Page Code | หมายเหตุ |
   - State the page ranges/headings where each ID type appears and sample ID formats found (e.g. `LAW-xxx`, `SDD-xxx`)
   - List pages marked `[อ่านจากภาพ]` and their accuracy risk

5. Brief report to the user (Thai): documents newly converted/skipped/failed, summary from `_index.md`, pages read from images (should be human-reviewed as they may be inaccurate), and Activities with no reference document found yet.
