# Graph Report - AI  (2026-09-22)

## Corpus Check
- 32 files · ~37,296 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 172 nodes · 172 edges · 27 communities (19 shown, 8 thin omitted)
- Extraction: 94% EXTRACTED · 5% INFERRED · 1% AMBIGUOUS · INFERRED: 9 edges (avg confidence: 0.84)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `393cad97`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- ecmis-trace project
- ECMIS Master Activity Template (converted)
- convert_docs.py
- graphify skill (knowledge graph pipeline)
- /ecmis — Run an Activity through every step
- graphify reference: extra exports and benchmark
- graphify reference: query, path, explain
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native CLAUDE.md integration
- graphify reference: incremental update and cluster-only
- Activity (numbered, e.g. Activity 5)
- Work one Activity at a time, stop for review
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- Step 5 — Check output
- Step 1 — Prepare docs (convert with markitdown)
- Step 2 — Extract
- Step 3 — Verify vs code
- Step 4 — Update Excel
- Releasing the ECMIS skill
- Invoke-Py
- build-ecmis-zip.sh script
- install.sh script
- Procedure
- Code map (graphify) — used in steps 3 and 6
- Parallel work with sub-agents (Sonnet) — used in steps 2, 3 and 6

## God Nodes (most connected - your core abstractions)
1. `ECMIS Master Activity Template (converted)` - 21 edges
2. `/ecmis — Run an Activity through every step` - 11 edges
3. `Procedure` - 9 edges
4. `Parallel work with sub-agents (Sonnet) — used in steps 2, 3 and 6` - 9 edges
5. `convert_one()` - 8 edges
6. `graphify reference: extra exports and benchmark` - 8 edges
7. `convert_pdf()` - 6 edges
8. `ecmis-trace project` - 6 edges
9. `graphify skill (knowledge graph pipeline)` - 6 edges
10. `main()` - 5 edges

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

## Communities (27 total, 8 thin omitted)

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

### Community 4 - "/ecmis — Run an Activity through every step"
Cohesion: 0.17
Nodes (11): /ecmis — Run an Activity through every step, Final summary (in Thai), Overview, Resuming interrupted work, Step 0 — Readiness check, Step 1 — Prepare docs, Step 2 — Extract, Step 3 — Verify vs code (+3 more)

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

### Community 14 - "Step 5 — Check output"
Cohesion: 0.40
Nodes (4): Checks, Report (Thai), Scope, Step 5 — Check output

### Community 15 - "Step 1 — Prepare docs (convert with markitdown)"
Cohesion: 0.50
Nodes (3): Procedure, Scope, Step 1 — Prepare docs (convert with markitdown)

### Community 16 - "Step 2 — Extract"
Cohesion: 0.50
Nodes (3): Procedure, Scope, Step 2 — Extract

### Community 17 - "Step 3 — Verify vs code"
Cohesion: 0.50
Nodes (3): Procedure, Scope, Step 3 — Verify vs code

### Community 18 - "Step 4 — Update Excel"
Cohesion: 0.50
Nodes (3): Preconditions, Procedure, Step 4 — Update Excel

### Community 24 - "Procedure"
Cohesion: 0.17
Nodes (11): 1. Check whether user-flow tests already exist, 2. Gather the user flows, 3. Prepare to run the prototype, 4. Extracting screen details, 5. ⏸ Checkpoint 3 — confirm before writing tests into the prototype, 6. Write the tests, 7. Install and run until all pass, 8. Record and report (+3 more)

### Community 25 - "Code map (graphify) — used in steps 3 and 6"
Cohesion: 0.33
Nodes (5): 1. Check graphify is available, 2. Build/update the map, 3. Use the map to find code, Code map (graphify) — used in steps 3 and 6, Principles

### Community 26 - "Parallel work with sub-agents (Sonnet) — used in steps 2, 3 and 6"
Cohesion: 0.20
Nodes (9): Asking the user (step 0), Merging (main agent, every time), Parallel work with sub-agents (Sonnet) — used in steps 2, 3 and 6, Part files, Principles, Rules every sub-agent prompt must include, Step 2 — Extract, Step 3 — Verify vs code (+1 more)

## Ambiguous Edges - Review These
- `Sheet 11_Process_Step_Detail` → `Sheet 11_Screen_Sequence`  [AMBIGUOUS]
  ecmis-trace/CLAUDE.md · relation: semantically_similar_to

## Knowledge Gaps
- **83 isolated node(s):** `build-ecmis-zip.sh script`, `install.sh script`, `For /graphify add`, `For --watch`, `Step 6b - Wiki (only if --wiki flag)` (+78 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **8 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What is the exact relationship between `Sheet 11_Process_Step_Detail` and `Sheet 11_Screen_Sequence`?**
  _Edge tagged AMBIGUOUS (relation: semantically_similar_to) - confidence is low._
- **What connects `build-ecmis-zip.sh script`, `install.sh script`, `For /graphify add` to the rest of the system?**
  _83 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ECMIS Master Activity Template (converted)` be split into smaller, more focused modules?**
  _Cohesion score 0.08866995073891626 - nodes in this community are weakly interconnected._