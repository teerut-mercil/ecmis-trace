# Step 2 — Extract

Extract the given Activity's data from work/docs into work/extract/A{no.}_extract.md with a page reference for every item.

Activity: **{Activity}**

## Scope
- **Never touch any Excel file** — you may only read the template (for column headers) and the output (if present, for existing IDs)
- Use only `work/docs/` as the source; if it doesn't exist yet, do step 1 first

## Procedure
1. Open `work/docs/_index.md` and find the documents and page ranges/headings related to Activity {Activity}
2. Read the column headers in row 5 of every template sheet so the extracted sections cover everything the template needs
3. If the output file exists, read this Activity's existing IDs (FLOW/SCR/TC/DOC/TD/ISS/TR) to match items to existing IDs — never assign new IDs in this file; use `NEW-1`, `NEW-2`, … for items without an ID
4. Extract into `work/extract/A{2-digit no.}_extract.md` (e.g. `A05_extract.md`), sectioned by sheet:
   - 01 ภาพรวม Activity / 02 AS-IS–TO-BE / 03 ใครทำอะไร
   - 04 Main Flow (every Step: performer, Input, Process, Decision, Forward, Return/Rework, Exit/Handoff, Output, SLA, Evidence)
   - 05 Supporting Flow / 06 จุดเชื่อม / 07 Gap-Feature / 08 Feature / 09 Permission
   - 11 Process Step Detail (LAW / Function No., SDD ID, Page Code, Actor, Trigger, Precondition, Input, buttons, Business Logic, Validation, Decision, Next LAW, Return Path, Output Doc/Status, Notification, Audit, Permission, Expected Result)
   - 11 Screen Sequence (screens in order, buttons, next screen for both Forward and Return)
   - 12 Document Matrix / 13 LAW Transition
   - 14–15 required Test Cases and Test Steps (Happy Path, Negative, Return/Rework per Decision) / 17 Test Data
5. **Every item must have a source** per the document's citation style in `_index.md`: `[เล่ม น.xx]` (PDF), `[เล่ม สไลด์ xx]` (PPTX), `[เล่ม §หัวข้อ]` (DOCX etc.) — data from `[อ่านจากภาพ]` pages gets `[อ่านจากภาพ]` appended to the source
6. Compare with existing draft data in the output/template (Draft status) and mark each item: `ตรงเล่ม` / `ไม่ตรงเล่ม (ค่าเล่ม: …)` / `ไม่พบในเล่ม`
7. At the end of the file, add a **"รายการคำถาม"** section for anything not found or where documents contradict each other: missing sheet/cell, question for a subject expert, pages/headings already searched
8. **Never guess** — write `— ไม่พบ —` for cells not found and carry them to the question list
9. Report to the user (Thai): counts of Steps/screens/Transitions/Test Cases extracted, number of questions, items differing from the draft, then go to Checkpoint 1 in SKILL.md
