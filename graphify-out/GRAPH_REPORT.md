# Graph Report - AI  (2026-09-21)

## Corpus Check
- 22 files · ~28,097 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 104 nodes · 129 edges · 14 communities (10 shown, 4 thin omitted)
- Extraction: 92% EXTRACTED · 7% INFERRED · 1% AMBIGUOUS · INFERRED: 9 edges (avg confidence: 0.84)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `5e5970bb`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- /ecmis-update command
- ECMIS Master Activity Template (converted)
- Output update rules (match by ID, backup, no protected rows, confirm before write)
- graphify skill (knowledge graph pipeline)
- /ecmis-prepare command
- graphify reference: extra exports and benchmark
- graphify reference: query, path, explain
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native CLAUDE.md integration
- graphify reference: incremental update and cluster-only
- Activity (numbered, e.g. Activity 5)
- Work one Activity at a time, stop for review
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio

## God Nodes (most connected - your core abstractions)
1. `ECMIS Master Activity Template (converted)` - 21 edges
2. `/ecmis-update command` - 11 edges
3. `graphify reference: extra exports and benchmark` - 8 edges
4. `/ecmis-check command` - 8 edges
5. `/ecmis-verify command` - 8 edges
6. `/ecmis-prepare command` - 8 edges
7. `output/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx (single deliverable)` - 7 edges
8. `ecmis-trace CLAUDE.md` - 7 edges
9. `ecmis-trace README` - 7 edges
10. `/ecmis-extract command` - 7 edges

## Surprising Connections (you probably didn't know these)
- `AI CLAUDE.md graphify rules` --semantically_similar_to--> `.claude CLAUDE.md`  [INFERRED] [semantically similar]
  CLAUDE.md → .claude/CLAUDE.md
- `graphify rules` --references--> `graphify skill (knowledge graph pipeline)`  [EXTRACTED]
  .agents/rules/graphify.md → .claude/skills/graphify/SKILL.md
- `graphify workflow` --references--> `graphify skill (knowledge graph pipeline)`  [EXTRACTED]
  .agents/workflows/graphify.md → .claude/skills/graphify/SKILL.md
- `AI CLAUDE.md graphify rules` --references--> `graphify skill (knowledge graph pipeline)`  [EXTRACTED]
  CLAUDE.md → .claude/skills/graphify/SKILL.md
- `LAW / Function No. process step` --references--> `Sheet 11_Process_Step_Detail`  [INFERRED]
  ecmis-trace/CLAUDE.md → graphify-out/converted/ECMIS_Master_Activity_Template_FlowScreenTrace_ea116dc0.md

## Hyperedges (group relationships)
- **ECMIS per-Activity command pipeline** — ecmis_trace_claude_commands_ecmis_prepare_doc, ecmis_trace_claude_commands_ecmis_extract_doc, ecmis_trace_claude_commands_ecmis_verify_doc, ecmis_trace_claude_commands_ecmis_update_doc, ecmis_trace_claude_commands_ecmis_check_doc [EXTRACTED 1.00]
- **Flow to Test Case traceability chain** — graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_04_mainflow, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_11_process_step_detail, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_14_testcase_master, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_15_test_steps, graphify_out_converted_ecmis_master_activity_template_flowscreentrace_ea116dc0_16_traceability [INFERRED 0.75]
- **Output update safeguards** — ecmis_trace_claude_output_backup, ecmis_trace_claude_protected_rows, ecmis_trace_claude_highlight_convention, ecmis_trace_claude_commands_ecmis_update_confirm_plan, ecmis_trace_claude_commands_ecmis_update_change_log_entries [INFERRED 0.85]

## Communities (14 total, 4 thin omitted)

### Community 0 - "/ecmis-update command"
Cohesion: 0.20
Nodes (19): Six check items: coverage, source, IDs/links, formulas, dropdown, protected rows, /ecmis-check command, Read-only validation (no edits), /ecmis-extract command, A{nn}_extract.md, Plan and user confirmation before writing, /ecmis-update command, [code] tag for screen-level data filled from code (+11 more)

### Community 1 - "ECMIS Master Activity Template (converted)"
Cohesion: 0.10
Nodes (26): Draft rows reconciled against docs, Dropdown values only from 99_Lists or inline list, LAW / Function No. process step, Missing data or doc/code mismatch opens Open Issue; doc value wins, Test Cases must cover Happy Path, Negative, Return/Rework, Sheet 00_Activity_Index, Sheet 01_ภาพรวม_Activity, Sheet 02_ASIS_TOBE (+18 more)

### Community 2 - "Output update rules (match by ID, backup, no protected rows, confirm before write)"
Cohesion: 0.22
Nodes (9): 18_Change_Log entries (CHG, round, old/new value, source), Highlight FFF2CC modified, E2EFDA added, HYPERLINK formulas and fixed-range formulas (no delete_rows), No-guessing rule: every filled cell needs Source Ref, openpyxl (non data_only) editing tooling, Protected: confirmed rows and Actual/Test/Step Result, Defect ID, Source recorded in 18_Change_Log for tabs without Source column, Output update rules (match by ID, backup, no protected rows, confirm before write) (+1 more)

### Community 3 - "graphify skill (knowledge graph pipeline)"
Cohesion: 0.29
Nodes (8): graphify rules, graphify workflow, .claude CLAUDE.md, AI CLAUDE.md graphify rules, graphify extraction spec, graphify extraction spec, graphify SKILL, graphify skill (knowledge graph pipeline)

### Community 4 - "/ecmis-prepare command"
Cohesion: 0.33
Nodes (7): /ecmis-prepare command, work/docs/_index.md per-book summary, [OCR] tagging and Thai OCR accuracy warning, Page-number markers ===== หน้า n / N =====, input/docs (primary source of truth), work/docs (text with page numbers), work/extract (per-Activity extract/verify files)

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

## Ambiguous Edges - Review These
- `Sheet 11_Process_Step_Detail` → `Sheet 11_Screen_Sequence`  [AMBIGUOUS]
  ecmis-trace/CLAUDE.md · relation: semantically_similar_to

## Knowledge Gaps
- **43 isolated node(s):** `For /graphify add`, `For --watch`, `Step 6b - Wiki (only if --wiki flag)`, `Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag)`, `Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag)` (+38 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What is the exact relationship between `Sheet 11_Process_Step_Detail` and `Sheet 11_Screen_Sequence`?**
  _Edge tagged AMBIGUOUS (relation: semantically_similar_to) - confidence is low._
- **Why does `ECMIS Master Activity Template (converted)` connect `ECMIS Master Activity Template (converted)` to `Output update rules (match by ID, backup, no protected rows, confirm before write)`?**
  _High betweenness centrality (0.219) - this node is a cross-community bridge._
- **Why does `Sheet 18_Change_Log` connect `Output update rules (match by ID, backup, no protected rows, confirm before write)` to `ECMIS Master Activity Template (converted)`?**
  _High betweenness centrality (0.171) - this node is a cross-community bridge._
- **Why does `/ecmis-update command` connect `/ecmis-update command` to `Output update rules (match by ID, backup, no protected rows, confirm before write)`?**
  _High betweenness centrality (0.140) - this node is a cross-community bridge._
- **What connects `For /graphify add`, `For --watch`, `Step 6b - Wiki (only if --wiki flag)` to the rest of the system?**
  _43 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ECMIS Master Activity Template (converted)` be split into smaller, more focused modules?**
  _Cohesion score 0.10153846153846154 - nodes in this community are weakly interconnected._