# Graph Report - AI  (2026-09-21)

## Corpus Check
- Corpus is ~28,097 words - fits in a single context window. You may not need a graph.

## Summary
- 71 nodes · 103 edges · 12 communities (8 shown, 4 thin omitted)
- Extraction: 90% EXTRACTED · 9% INFERRED · 1% AMBIGUOUS · INFERRED: 9 edges (avg confidence: 0.84)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Check & Update Workflow
- Overview & Catalog Sheets
- Extract & Verify Rules
- Graphify Tooling Docs
- Prepare & Source Docs
- Process Flow Sheets
- Test Case Sheets
- Open Issues & Reconcile
- Dropdown Lists
- Excel Formula Tooling
- Activity Unit
- One-Activity Review

## God Nodes (most connected - your core abstractions)
1. `ECMIS Master Activity Template (converted)` - 21 edges
2. `/ecmis-update command` - 11 edges
3. `/ecmis-check command` - 8 edges
4. `/ecmis-prepare command` - 8 edges
5. `/ecmis-verify command` - 8 edges
6. `ecmis-trace CLAUDE.md` - 7 edges
7. `ecmis-trace README` - 7 edges
8. `/ecmis-extract command` - 7 edges
9. `output/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx (single deliverable)` - 7 edges
10. `ecmis-trace project` - 6 edges

## Surprising Connections (you probably didn't know these)
- `AI CLAUDE.md graphify rules` --semantically_similar_to--> `.claude CLAUDE.md`  [INFERRED] [semantically similar]
  CLAUDE.md → .claude/CLAUDE.md
- `AI CLAUDE.md graphify rules` --references--> `graphify skill (knowledge graph pipeline)`  [EXTRACTED]
  CLAUDE.md → .claude/skills/graphify/SKILL.md
- `graphify rules` --references--> `graphify skill (knowledge graph pipeline)`  [EXTRACTED]
  .agents/rules/graphify.md → .claude/skills/graphify/SKILL.md
- `graphify workflow` --references--> `graphify skill (knowledge graph pipeline)`  [EXTRACTED]
  .agents/workflows/graphify.md → .claude/skills/graphify/SKILL.md
- `Test Cases must cover Happy Path, Negative, Return/Rework` --references--> `Sheet 14_TestCase_Master`  [EXTRACTED]
  ecmis-trace/CLAUDE.md → graphify-out/converted/ECMIS_Master_Activity_Template_FlowScreenTrace_ea116dc0.md

## Hyperedges (group relationships)
- **ECMIS per-Activity command pipeline** — ecmis_trace_claude_commands_ecmis_prepare_doc, ecmis_trace_claude_commands_ecmis_extract_doc, ecmis_trace_claude_commands_ecmis_verify_doc, ecmis_trace_claude_commands_ecmis_update_doc, ecmis_trace_claude_commands_ecmis_check_doc [EXTRACTED 1.00]
- **Output update safeguards** — ecmis_trace_claude_output_backup, ecmis_trace_claude_protected_rows, ecmis_trace_claude_highlight_convention, ecmis_trace_claude_commands_ecmis_update_confirm_plan, ecmis_trace_claude_commands_ecmis_update_change_log_entries [INFERRED 0.85]
- **Flow to Test Case traceability chain** — graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_04_mainflow, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_11_process_step_detail, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_14_testcase_master, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_15_test_steps, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_16_traceability [INFERRED 0.75]

## Communities (12 total, 4 thin omitted)

### Community 0 - "Check & Update Workflow"
Cohesion: 0.21
Nodes (17): Six check items: coverage, source, IDs/links, formulas, dropdown, protected rows, /ecmis-check command, Read-only validation (no edits), 18_Change_Log entries (CHG, round, old/new value, source), Plan and user confirmation before writing, /ecmis-update command, ecmis-trace CLAUDE.md, ecmis-trace project (+9 more)

### Community 1 - "Overview & Catalog Sheets"
Cohesion: 0.20
Nodes (10): Sheet 01_ภาพรวม_Activity, Sheet 02_ASIS_TOBE, Sheet 03_ใครทำอะไร, Sheet 05_SupportingFlow, Sheet 06_จุดเชื่อม, Sheet 07_Gap_Feature, Sheet 08_Feature_Catalog, Sheet 09_Permission (+2 more)

### Community 2 - "Extract & Verify Rules"
Cohesion: 0.25
Nodes (9): /ecmis-extract command, A{nn}_extract.md, [code] tag for screen-level data filled from code, /ecmis-verify command, A{nn}_verify.md, Verify outcomes: ตรงเล่ม / ไม่ตรงเล่ม / ไม่พบในโค้ด, No-guessing rule: every filled cell needs Source Ref, Source recorded in 18_Change_Log for tabs without Source column (+1 more)

### Community 3 - "Graphify Tooling Docs"
Cohesion: 0.29
Nodes (8): graphify rules, graphify workflow, .claude CLAUDE.md, AI CLAUDE.md graphify rules, graphify extraction spec, graphify extraction spec, graphify SKILL, graphify skill (knowledge graph pipeline)

### Community 4 - "Prepare & Source Docs"
Cohesion: 0.33
Nodes (7): /ecmis-prepare command, work/docs/_index.md per-book summary, [OCR] tagging and Thai OCR accuracy warning, Page-number markers ===== หน้า n / N =====, input/docs (primary source of truth), work/docs (text with page numbers), work/extract (per-Activity extract/verify files)

### Community 5 - "Process Flow Sheets"
Cohesion: 0.40
Nodes (5): LAW / Function No. process step, Sheet 04_MainFlow, Sheet 11_Process_Step_Detail, Sheet 11_Screen_Sequence, Sheet 13_LAW_Transition

### Community 6 - "Test Case Sheets"
Cohesion: 0.50
Nodes (5): Test Cases must cover Happy Path, Negative, Return/Rework, Sheet 14_TestCase_Master, Sheet 15_Test_Steps, Sheet 16_Traceability, Sheet 17_Test_Data

### Community 7 - "Open Issues & Reconcile"
Cohesion: 0.50
Nodes (4): Draft rows reconciled against docs, Missing data or doc/code mismatch opens Open Issue; doc value wins, Sheet 00_Activity_Index, Sheet 10_Open_Issue

## Ambiguous Edges - Review These
- `Sheet 11_Process_Step_Detail` → `Sheet 11_Screen_Sequence`  [AMBIGUOUS]
  ecmis-trace/CLAUDE.md · relation: semantically_similar_to

## Knowledge Gaps
- **24 isolated node(s):** `graphify SKILL`, `graphify rules`, `graphify workflow`, `graphify extraction spec`, `ID patterns FLOW-Axx-nnn SCR TR TC DOC TD ISS CHG` (+19 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What is the exact relationship between `Sheet 11_Process_Step_Detail` and `Sheet 11_Screen_Sequence`?**
  _Edge tagged AMBIGUOUS (relation: semantically_similar_to) - confidence is low._
- **Why does `ECMIS Master Activity Template (converted)` connect `Overview & Catalog Sheets` to `Extract & Verify Rules`, `Process Flow Sheets`, `Test Case Sheets`, `Open Issues & Reconcile`, `Dropdown Lists`?**
  _High betweenness centrality (0.477) - this node is a cross-community bridge._
- **Why does `Sheet 18_Change_Log` connect `Extract & Verify Rules` to `Check & Update Workflow`, `Overview & Catalog Sheets`?**
  _High betweenness centrality (0.372) - this node is a cross-community bridge._
- **Why does `/ecmis-update command` connect `Check & Update Workflow` to `Extract & Verify Rules`?**
  _High betweenness centrality (0.305) - this node is a cross-community bridge._
- **What connects `graphify SKILL`, `graphify rules`, `graphify workflow` to the rest of the system?**
  _24 weakly-connected nodes found - possible documentation gaps or missing edges._