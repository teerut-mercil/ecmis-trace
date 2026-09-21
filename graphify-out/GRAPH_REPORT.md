# Graph Report - AI  (2026-09-21)

## Corpus Check
- 24 files · ~29,452 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 132 nodes · 139 edges · 19 communities (15 shown, 4 thin omitted)
- Extraction: 93% EXTRACTED · 6% INFERRED · 1% AMBIGUOUS · INFERRED: 9 edges (avg confidence: 0.84)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `3bfe5231`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ecmis-trace project
- ECMIS Master Activity Template (converted)
- convert_docs.py
- graphify skill (knowledge graph pipeline)
- /ecmis — พาทำ Activity ครบทุกขั้น
- graphify reference: extra exports and benchmark
- graphify reference: query, path, explain
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native CLAUDE.md integration
- graphify reference: incremental update and cluster-only
- Activity (numbered, e.g. Activity 5)
- Work one Activity at a time, stop for review
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- ขั้น 5 — ตรวจไฟล์ output
- ขั้น 1 — เตรียมเอกสาร (แปลงเล่มด้วย markitdown)
- ขั้น 2 — สกัดข้อมูล
- ขั้น 3 — เทียบกับโค้ด
- ขั้น 4 — อัปเดต Excel

## God Nodes (most connected - your core abstractions)
1. `ECMIS Master Activity Template (converted)` - 21 edges
2. `/ecmis — พาทำ Activity ครบทุกขั้น` - 10 edges
3. `convert_one()` - 8 edges
4. `graphify reference: extra exports and benchmark` - 8 edges
5. `convert_pdf()` - 6 edges
6. `ecmis-trace project` - 6 edges
7. `graphify skill (knowledge graph pipeline)` - 6 edges
8. `main()` - 5 edges
9. `graphify reference: query, path, explain` - 5 edges
10. `output/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx (single deliverable)` - 5 edges

## Surprising Connections (you probably didn't know these)
- `AI CLAUDE.md graphify rules` --semantically_similar_to--> `.claude CLAUDE.md`  [INFERRED] [semantically similar]
  CLAUDE.md → .claude/CLAUDE.md
- `LAW / Function No. process step` --references--> `Sheet 11_Process_Step_Detail`  [INFERRED]
  ecmis-trace/CLAUDE.md → graphify-out/converted/ECMIS_Master_Activity_Template_FlowScreenTrace_ea116dc0.md
- `Test Cases must cover Happy Path, Negative, Return/Rework` --references--> `Sheet 14_TestCase_Master`  [EXTRACTED]
  ecmis-trace/CLAUDE.md → graphify-out/converted/ECMIS_Master_Activity_Template_FlowScreenTrace_ea116dc0.md
- `graphify rules` --references--> `graphify skill (knowledge graph pipeline)`  [EXTRACTED]
  .agents/rules/graphify.md → .claude/skills/graphify/SKILL.md
- `graphify workflow` --references--> `graphify skill (knowledge graph pipeline)`  [EXTRACTED]
  .agents/workflows/graphify.md → .claude/skills/graphify/SKILL.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Flow to Test Case traceability chain** — graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_04_mainflow, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_11_process_step_detail, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_14_testcase_master, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_15_test_steps, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_16_traceability [INFERRED 0.75]

## Communities (19 total, 4 thin omitted)

### Community 0 - "ecmis-trace project"
Cohesion: 0.15
Nodes (16): ecmis-trace CLAUDE.md, ecmis-trace project, Highlight FFF2CC modified, E2EFDA added, HYPERLINK formulas and fixed-range formulas (no delete_rows), ID patterns FLOW-Axx-nnn SCR TR TC DOC TD ISS CHG, input/code (screen-level verification source), input/docs (primary source of truth), E-CMIS Master Activity Template xlsx (+8 more)

### Community 1 - "ECMIS Master Activity Template (converted)"
Cohesion: 0.09
Nodes (29): Draft rows reconciled against docs, Dropdown values only from 99_Lists or inline list, LAW / Function No. process step, No-guessing rule: every filled cell needs Source Ref, Missing data or doc/code mismatch opens Open Issue; doc value wins, Source recorded in 18_Change_Log for tabs without Source column, Test Cases must cover Happy Path, Negative, Return/Rework, Sheet 00_Activity_Index (+21 more)

### Community 2 - "convert_docs.py"
Cohesion: 0.38
Nodes (11): check_deps(), convert_one(), convert_pdf(), convert_pptx(), main(), normalize_thai(), คืนค่า (markdown, info) — info ใช้ลง manifest และรายงาน, sha256() (+3 more)

### Community 3 - "graphify skill (knowledge graph pipeline)"
Cohesion: 0.29
Nodes (8): graphify rules, graphify workflow, .claude CLAUDE.md, AI CLAUDE.md graphify rules, graphify extraction spec, graphify extraction spec, graphify SKILL, graphify skill (knowledge graph pipeline)

### Community 4 - "/ecmis — พาทำ Activity ครบทุกขั้น"
Cohesion: 0.18
Nodes (10): /ecmis — พาทำ Activity ครบทุกขั้น, ขั้น 0 — ตรวจความพร้อม, ขั้น 1 — เตรียมเอกสาร, ขั้น 2 — สกัดข้อมูล, ขั้น 3 — เทียบกับโค้ด, ขั้น 4 — อัปเดต Excel, ขั้น 5 — ตรวจไฟล์ output, ถ้างานค้างกลางทาง (+2 more)

### Community 5 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 6 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 7 - "graphify reference: add a URL and watch a folder"
Cohesion: 0.50
Nodes (3): For /graphify add, For --watch, graphify reference: add a URL and watch a folder

### Community 8 - "graphify reference: commit hook and native CLAUDE.md integration"
Cohesion: 0.50
Nodes (3): For git commit hook, For native CLAUDE.md integration, graphify reference: commit hook and native CLAUDE.md integration

### Community 9 - "graphify reference: incremental update and cluster-only"
Cohesion: 0.50
Nodes (3): For --cluster-only, For --update (incremental re-extraction), graphify reference: incremental update and cluster-only

### Community 14 - "ขั้น 5 — ตรวจไฟล์ output"
Cohesion: 0.40
Nodes (4): ขั้น 5 — ตรวจไฟล์ output, ขอบเขต, รายการตรวจ, รายงาน

### Community 15 - "ขั้น 1 — เตรียมเอกสาร (แปลงเล่มด้วย markitdown)"
Cohesion: 0.50
Nodes (3): ขั้น 1 — เตรียมเอกสาร (แปลงเล่มด้วย markitdown), ขั้นตอน, ขอบเขต

### Community 16 - "ขั้น 2 — สกัดข้อมูล"
Cohesion: 0.50
Nodes (3): ขั้น 2 — สกัดข้อมูล, ขั้นตอน, ขอบเขต

### Community 17 - "ขั้น 3 — เทียบกับโค้ด"
Cohesion: 0.50
Nodes (3): ขั้น 3 — เทียบกับโค้ด, ขั้นตอน, ขอบเขต

### Community 18 - "ขั้น 4 — อัปเดต Excel"
Cohesion: 0.50
Nodes (3): ขั้น 4 — อัปเดต Excel, ขั้นตอน, เงื่อนไขก่อนเริ่ม

## Ambiguous Edges - Review These
- `Sheet 11_Process_Step_Detail` → `Sheet 11_Screen_Sequence`  [AMBIGUOUS]
  ecmis-trace/CLAUDE.md · relation: semantically_similar_to

## Knowledge Gaps
- **58 isolated node(s):** `For /graphify add`, `For --watch`, `Step 6b - Wiki (only if --wiki flag)`, `Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag)`, `Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag)` (+53 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What is the exact relationship between `Sheet 11_Process_Step_Detail` and `Sheet 11_Screen_Sequence`?**
  _Edge tagged AMBIGUOUS (relation: semantically_similar_to) - confidence is low._
- **What connects `For /graphify add`, `For --watch`, `Step 6b - Wiki (only if --wiki flag)` to the rest of the system?**
  _58 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ECMIS Master Activity Template (converted)` be split into smaller, more focused modules?**
  _Cohesion score 0.08866995073891626 - nodes in this community are weakly interconnected._