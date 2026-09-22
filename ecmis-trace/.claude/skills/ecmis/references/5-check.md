# Step 5 — Check output

Validate the output file (coverage, sources, IDs/references/hyperlinks, formulas, dropdowns, protected rows) and report failing items.

Activity: **{Activity}** (if not given, check every Activity in the file)

## Scope
- **Read-only** — never modify the output file; report only
- File checked: `output/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx`; if missing, stop and tell the user
- Load with openpyxl normally (not data_only) to inspect formulas

## Checks
1. **Coverage** — every LAW Step (rows in `11_Process_Step_Detail` and `16_Traceability` with LAW / Function No.) has at least 1 Test Case that actually exists in `14_TestCase_Master`, and each Step with a Decision has Test Cases covering Happy Path, Negative, Return/Rework
2. **Sources** — every data row in sheets with a `Source Ref / Page` (or `Source / Rule`) column has a value there; sheets without a source column must have a `18_Change_Log` entry with a source for that row
3. **IDs and cross-sheet references**
   - IDs unique within their sheet and matching the pattern (`FLOW-Axx-nnn`, `SCR-Axx-nnn-nn`, `TR-Axx-nnn`, `TC-Axx-nnn`, `DOC-nnn`, `TD-nnn`, `ISS-nnn`, `CHG-nnn`)
   - Referenced IDs actually exist: Flow ID, Primary Screen Seq ID, Screen Seq ID, Previous/Next Screen, From/To Screen Seq ID, Transition Ref, Test Case ID, Test Data ID, Related Test Case ID
   - No deleted IDs (per `18_Change_Log`) reused
   - **Hyperlinks** (`Link to Flow`, `Link to Screen Sequence`, `Flow Link`): parse target sheet/row from the HYPERLINK formula and check that row's Flow ID / Screen Seq ID matches the source row, and the link text matches the ID (for `Flow Link`)
4. **Formulas** — every formula per the CLAUDE.md patterns is present on all data rows; no `#REF!` / wrong sheet names / ranges drifted from the template; cached values (if any) are not errors — except the "HYPERLINK is not implemented" cache from the template (check the formula instead)
5. **Dropdowns** — every data-validated cell's value is in the allowed list (99_Lists or the cell's inline list), and data validation / table frame / sheet names / column order still match the template
6. **Protected rows** — compare with the latest file in `output/backup/`: "ยืนยันแล้ว" rows (matched by ID) must be unchanged, and columns `Actual Result`, `Test Result`, `Step Result`, `Defect ID` must be unchanged. If no backup exists, report this check as skipped

## Report (Thai)
- Summary table: ข้อ | ผ่าน/ไม่ผ่าน | จำนวนรายการที่ไม่ผ่าน
- All failing items: ข้อ | แท็บ | แถว | รหัส | คอลัมน์ | ปัญหา | ข้อเสนอแก้
- Don't fix anything yourself; the user decides whether to fix by rerunning `/ecmis {Activity}` or opening an Open Issue
