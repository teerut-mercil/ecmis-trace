# Step 3 — Verify vs code

Compare the given Activity's extract file with the source code in input/code, fill screen-level data, and mark each item as matching/not matching the documents.

Activity: **{Activity}**

## Scope
- **Never touch any Excel file**
- Never modify files in `input/code/` or the repo it points to (read-only) — except step 6 may add Playwright test files after user confirmation
- `work/extract/A{2-digit no.}_extract.md` must exist; if not, do step 2 first

## Procedure
1. Read `input/code/`; if it is a file pointing to a repo path, open that repo. If the path is inaccessible, stop and tell the user
2. Find code related to this Activity by searching Page Code, LAW / Function No., SDD ID, screen names, and keywords from the extract file
   - If a code map exists (`work/graph/graphify-out/graph.json`), start with `graphify query` / `explain` / `path` per `code-graph.md` item 3 to find relevant files and links (screen → button → validation → next status), then open the actual files
   - No map, or not found in the map → search files normally (a `ไม่พบในโค้ด` result must come from a file search, not from the map alone)
3. For every **screen-level** item in the extract file — Page Code, buttons/Actions, statuses (status/enum), validation, notifications, screen permissions, screen order/routes — check against code and mark:
   - `ตรงเล่ม` — code matches the document
   - `ไม่ตรงเล่ม` — give the code value and document value with sources for both (rule: use the document value; an Open Issue will be opened in the update step)
   - `ไม่พบในโค้ด`
   Every result must include a file path (and line if possible), e.g. `src/pages/case/CaseAccept.tsx:120`
4. **Fill screen-level data missing from the documents** using code (e.g. button labels, validation messages, status after click), tagged `[code]` with the path as source — never use code in place of business data the documents should define; if the documents lack that business data, keep it as a question
5. Items found in code but not in the documents (extra screens/buttons/statuses) → separate section "พบในโค้ดแต่ไม่พบในเล่ม" and add them as questions
6. Save results to `work/extract/A{2-digit no.}_verify.md` (never overwrite the extract file), containing:
   - Per-item result table: หัวข้อ | ค่าในเล่ม [ที่มา] | ค่าในโค้ด [path] | ผล
   - Screen-level data filled from code
   - Additional questions
7. Report to the user (Thai): counts of ตรงเล่ม / ไม่ตรงเล่ม / ไม่พบในโค้ด, all mismatches, and new questions, then go to step 4
