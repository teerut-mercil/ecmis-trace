# ecmis-trace — Project Rules

This project fills in and updates the E-CMIS Master Activity Template (Flow / Screen / LAW / Test Case / Traceability) one Activity at a time, from the source documents and source code.

**Language:** Always talk to the user in simple Thai. Thai text in quotes/backticks in these instructions (sheet names, column names, status values, citation formats, labels, markers, messages) is a literal value — use it verbatim, never translate it.

## Sources and Output

- `input/docs/` = source documents, the **primary source of truth**
- `input/code/` = source code (or a file pointing to a repo path), used **only to confirm and fill screen-level data**: Page Code, buttons, statuses, validation, notifications — not a primary source
- The prototype in `input/code/` is read-only, **except** step 6 may add Playwright tests per user flow (test files / test config only, never screen code) after the user confirms at checkpoint 3
- `template/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx` = original template, **never edit**
- `work/docs/` = documents converted to Markdown with **markitdown** (script `scripts/convert_docs.py` in the skill folder) — PDF has page numbers, PPTX has slide numbers, DOCX and others are cited by heading
- `work/extract/` = per-Activity extracted data (extract / verify / plan)
- `work/extract/_parts/` = temporary sub-agent part files (when the user chooses parallel work — see `references/subagents.md` in the skill folder). The main agent merges them into the Activity files and deletes them; they are not a data source
- `work/graph/` = code map (graphify) of the prototype, used to locate code in steps 3 and 6 — create it only here, never create `graphify-out/` inside the prototype repo
- Every step runs through the skill `/ecmis <Activity no.>` (installed at `.claude/skills/ecmis/` in the project or `~/.claude/skills/ecmis/` globally)
- There is exactly one output: `output/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx`. **Never create any other output file** (step 6 Playwright tests and screenshots live in the prototype repo and don't count as output)
- `output/backup/` = backup taken before every edit (not output)

## Data Rules

1. **Never guess.** Every filled cell must have a source in the `Source Ref / Page` column (format: `ชื่อเล่ม น.xx` for PDF, `ชื่อเล่ม สไลด์ xx` for PPTX, `ชื่อเล่ม §ชื่อหัวข้อ` for DOCX and page-less files, `path/ไฟล์:บรรทัด` for code — data read from images gets the suffix `[อ่านจากภาพ]`). See "Sources for sheets without a Source Ref column" below.
2. **Data not found** → leave blank and open an item in `10_Open_Issue` stating the Activity, the missing sheet/cell, and the question for a subject expert.
3. **Document and code disagree** → use the document value and open an Open Issue listing both values with sources.
4. **Existing draft data** (status "Draft - รอเทียบเล่ม" or "Draft / รอเทียบเล่ม") must be compared with the documents:
   - Matches → keep and add the source
   - Differs → correct it per the document
   - Not in the documents → keep and open an Open Issue
5. **Dropdown values must come only from sheet `99_Lists`.** If a cell's dropdown has an inline list defined in the template (e.g. Scenario Type, Screen Type, Test Result), use only values from that list. Never type values outside the list.
6. **IDs follow the existing pattern and must be unique**: `FLOW-A05-001`, `SCR-A05-001-01`, `TR-A05-001`, `TC-A05-001`, `DOC-001`, `TD-001`, `ISS-001`, `CHG-001` (A05 = Activity 5, zero-padded to 2 digits)
7. **Test Cases must cover** Happy Path, Negative, and Return/Rework for each Step's Decision.
8. **One Activity at a time**; stop and summarize for review before moving to the next Activity.

## Output Update Rules

- If the output file doesn't exist, copy it from the template. If it exists, **always update the existing file**.
- Before every edit, back up to `output/backup/` with a timestamp in the name, e.g. `ECMIS_Master_Activity_Template_FlowScreenTrace_20260921-1530.xlsx`
- **Never touch** rows with status "ยืนยันแล้ว" or the columns `Actual Result`, `Test Result`, `Step Result`, `Defect ID`
- Match existing rows to new data **by ID, not by row order**
- Existing IDs never change number. New items continue from the highest number. IDs previously deleted (see `18_Change_Log`) are never reused.
- Value differs from the new version → update to the new value and log the old value in `18_Change_Log`
- Item not found in the new version → delete the row plus all rows referencing it in other sheets, and log the full row in `18_Change_Log`
  - Except rows that are "ยืนยันแล้ว" or already have test results/Defects → **do not delete**; open an Open Issue instead
- At the start of a run, clear the previous run's highlights. During the run, highlight edited cells **light yellow** (`FFF2CC`) and new rows **light green** (`E2EFDA`)
- **Before writing the file, always summarize adds/edits/deletes per sheet and get user confirmation**

## Template Structure Notes (apply in every step)

### Table layout
- Every sheet: row 1 = sheet title, row 2 = description, row 5 = column headers, data from row 6 to the last row of the table frame (e.g. `04_MainFlow` to row 205, `11_Screen_Sequence` to row 505)
- Add data in empty rows inside the table frame, using that row's style (never change fill/borders except for the highlight rules)
- `11_Process_Step_Detail` and `11_Screen_Sequence` share the number 11 — always refer to them by full sheet name

### Status columns (decide which rows are "ยืนยันแล้ว")
| Sheet | Status column |
|---|---|
| 01_ภาพรวม_Activity | สถานะยืนยัน |
| 03_ใครทำอะไร | สถานะยืนยัน |
| 04_MainFlow | สถานะยืนยัน |
| 05_SupportingFlow | สถานะยืนยัน |
| 06_จุดเชื่อม | สถานะยืนยัน |
| 07_Gap_Feature / 08_Feature_Catalog | สถานะ |
| 09_Permission | สถานะยืนยัน |
| 11_Process_Step_Detail | Confirmation Status |
| 16_Traceability | Confirmation |
| 11_Screen_Sequence | Screen Type = "Draft / รอเทียบเล่ม" means still a draft |

Sheets without a status column (12, 13, 14, 15, 17) inherit the status of the referenced Flow/Step row.

### Sources for sheets without a Source Ref column
- Sheets with a source column: `11_Process_Step_Detail`, `12_Document_Matrix`, `13_LAW_Transition`, `14_TestCase_Master`, `16_Traceability` (`Source Ref / Page`) and `17_Test_Data` (`Source / Rule`) → put the source in that column
- Sheets without a source column (00–09, 11_Screen_Sequence, 15_Test_Steps) → the source of every filled/edited cell must be in the `ที่มา` column of `18_Change_Log` (log both types เพิ่ม and แก้). **Never add new columns to the template**
- `10_Open_Issue` uses the `Ref / Meeting` column as its source

### Formulas and hyperlinks (keep them and point to the right rows)
- `00_Activity_Index`: `Open Issue` (COUNTIFS from 10_Open_Issue), `Completion %`
- `04_MainFlow`: `Screen Count` = COUNTIF(`11_Screen_Sequence`!D, Flow ID)
- `16_Traceability`: `Test Case Count`, `Coverage`, `Gap / Missing`
- Hyperlinks are formulas `=HYPERLINK("#'ชื่อแท็บ'!A{แถว}","ข้อความ")` in columns `Link to Flow` / `Link to Screen Sequence` (sheets 11_Process_Step_Detail, 14, 15, 16) and `Flow Link` (11_Screen_Sequence)
- **The row in a hyperlink must be the row where the target ID actually is** (look up by Flow ID / Screen Seq ID), not the same row number as the source row — whenever rows are added/deleted/moved, recompute hyperlinks for the whole sheet
- Formula ranges are fixed (e.g. `$A$6:$A$405`) — delete a row by **shifting the rows below up within the table frame**, then rewrite each row's formulas per the existing pattern. Never use Excel/openpyxl row deletion (`delete_rows`); it breaks the table frame, dropdowns, and formula ranges
- The cached value of HYPERLINK formulas in the template is an error left by the generator ("HYPERLINK is not implemented"); Excel recalculates on open — check the formula itself, not the cached value

### Tools
- Read code with the graphify code map (`references/code-graph.md` in the skill folder) as a locator — recorded sources must be `path/ไฟล์:บรรทัด` from actually opening the file. Without graphify, read code normally
- Convert documents with markitdown via `convert_docs.py` only — pages the script labels "ต้องอ่านจากภาพ" must be read by Claude from the original file
- Edit Excel with Python `openpyxl` (normal load, not `data_only=True`, so formulas are kept)
- Keep temporary scripts outside the project (scratchpad); never leave other .xlsx files in `output/`
