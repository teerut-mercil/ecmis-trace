# Step 4 — Update Excel

Fill or update the given Activity's data in the output file per the update rules (always confirm before writing), then go to step 5.

Activity: **{Activity}**

## Preconditions
- `work/extract/A{2-digit no.}_extract.md` and `work/extract/A{2-digit no.}_verify.md` must exist; if missing, do the missing step first
- The only writable file: `output/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx` (never edit the template)

## Procedure
1. **Prepare the file**
   - No output file yet → copy from `template/` as the output file
   - Exists → always use the existing file
2. **Plan (don't write yet)** from extract + verify vs. this Activity's data in the output file:
   - Match by ID (Flow ID, Screen Seq ID, Transition ID, Test Case ID, Document ID, Test Data ID, Issue ID), not row order
   - New items → continue from the highest number of that pattern (including numbers deleted per `18_Change_Log`); never reuse deleted numbers
   - Changed values → edit (keep old value for the Change Log)
   - Items not in the new version → delete, together with all referencing rows in other sheets (e.g. deleting a Flow → its Screen Sequence, Process Step, Transition, Test Case, Test Steps, Traceability rows referencing that Flow ID)
   - **Always skip** rows that are "ยืนยันแล้ว" and the columns `Actual Result`, `Test Result`, `Step Result`, `Defect ID`
   - Rows to delete that are "ยืนยันแล้ว" or have test results/Defects → don't delete; plan an Open Issue instead
   - Document vs code mismatch / data not found / draft not in documents → plan an Open Issue
   - Dropdown values must be in the allowed list (99_Lists or the cell's inline list)
   - Test Cases must cover Happy Path, Negative, Return/Rework per every Step's Decision
3. **⏸ Checkpoint 2 — show the plan for confirmation**, easy to read for non-technical users (Thai)
   - Save the full plan (ID, column, old → new value, source) to `work/extract/A{2-digit no.}_plan.md`
   - In chat, show in this order:
     1. Summary table `| แท็บ | เพิ่ม | แก้ | ลบ | Open Issue ใหม่ |`
     2. **Items to delete**, all of them (highest risk, shown first) — ID, short description, reason
     3. **Items to edit** — `รหัส · คอลัมน์: ค่าเดิม → ค่าใหม่ (ที่มา)`
     4. Items to add — if more than 15, show only counts and IDs per sheet and refer to the plan file
     5. Items skipped because "ยืนยันแล้ว"/has test results
   - Ask the user with AskUserQuestion:
     - `ยืนยันทั้งหมด`
     - `ยืนยัน แต่ไม่ลบ` — all deletions become Open Issues instead
     - `ขอแก้บางรายการ` — user states IDs to drop/change; revise the plan and ask again
     - `ยกเลิก` — don't write the file, end
   **Never write the file before confirmation**
4. **Back up** to `output/backup/ECMIS_Master_Activity_Template_FlowScreenTrace_{YYYYMMDD-HHMM}.xlsx` (skip only if the file was just copied from the template in this run)
5. **Write the file** with openpyxl:
   - Clear previous run's highlights (restore fill to the row's original style within the table frame)
   - Edited cells → light yellow `FFF2CC`, added rows → light green `E2EFDA`
   - Put the source in the sheet's Source Ref column (or in the Change Log for sheets without a source column)
   - Deletion: shift lower rows up within the table frame; never use `delete_rows`
   - Rewrite formulas for every data row per the existing pattern and recompute hyperlinks to point to the row where the target ID actually is
   - Log every item in `18_Change_Log`: Change ID (CHG-xxx continuing from the highest), round no. (continuing from the highest), date, Activity, sheet, row ID, column, type (เพิ่ม/แก้/ลบ), old value, new value, source, reason — for deletions store the whole row in the old-value cell
   - Open Open Issues in `10_Open_Issue` per the plan (ISS-xxx continuing from the highest, Status = เปิด)
6. **Go to step 5** immediately (`references/5-check.md`), then give the final summary per SKILL.md
