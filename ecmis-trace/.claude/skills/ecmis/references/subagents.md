# Parallel work with sub-agents (Sonnet) — used in steps 2, 3 and 6

Use **Sonnet** sub-agents as the main workers: split independent parts to run in parallel, while the main agent (coordinator) merges results, checks consistency, and is the only one who decides and writes final files.

## Principles
- **The user chooses in step 0** whether to use sub-agents (see "Asking the user") — if not, do every step solo as usual and stop reading this file
- Call sub-agents with the Agent tool using `model: sonnet` — send independent tasks as **multiple calls in one message** so they run in parallel
- Only the main agent: talks to the user, uses AskUserQuestion, assigns IDs/`NEW-n`, writes merged files (`_extract.md`, `_verify.md`, `_screens.md`, `_playwright.md`), and **writes the Excel file (step 4 never uses sub-agents)**
- **If sub-agents can't be used** (no Sonnet, Agent tool unavailable, sub-agent failed) → say so briefly and do that part solo; don't ask the user, don't stop
- Sub-agents per round: at most 4 — for small work (e.g. one short document, one flow) use fewer or do it yourself

## Rules every sub-agent prompt must include
Sub-agents can't see this conversation; the prompt must be self-contained and state all of:
1. Activity, this agent's scope (which part/Flow/sheet), and what is **not** its job (to avoid duplicating others)
2. Paths to read and **the single file it may write** (a part file per "Part files") — no other files
3. Read the project `CLAUDE.md` and the step's reference file (give the full path `<SKILL_DIR>/references/…`) and follow the data rules: never guess, every item has a source, tags `[อ่านจากภาพ]` / `[code]`
4. **Forbidden**: touching Excel files, modifying prototype code, asking the user, assigning real IDs (use `NEW-<group letter>-n`, e.g. `NEW-B-3`), running `graphify extract/update`
5. Anything not found or uncertain → write it under "รายการคำถาม" in the part file; don't stop to ask
6. Reply to the main agent briefly: item count, question count, problems hit (don't send the full content back — it's in the file)

## Part files
- Stored at `work/extract/_parts/A{nn}_<step>_<group>.md`, e.g. `A05_extract_B.md`, `A05_verify_FLOW-A05-002.md`, `A05_screens_FLOW-A05-001.md`
- At the start of a step, delete that step's old part files for this Activity (avoid stale data)
- After merging and checking → delete that step's part files; real results live only in the merged file

## Merging (main agent, every time)
1. Read all part files — if a group's sub-agent failed/didn't finish, do that group yourself before merging
2. **Remove duplicates** (same item from different groups) — match by existing ID first, then by name + source
3. **Check for conflicts** between groups (e.g. differently spelled Step/screen names, mismatched next status, different code-check results for the same component) → open the sources yourself and decide; if the documents contradict each other, raise a question
4. Renumber `NEW-<group>-n` to `NEW-1`, `NEW-2`, … sequentially across the file and fix every reference
5. **Spot-check sources**: at least 3 items per group (open the cited page/line) — if any is wrong, recheck that whole group
6. Merge all groups' questions into one list, removing duplicates
7. Report short progress, e.g. `ขั้น 2/6 รวมผลจาก 4 ส่วน — ตัดซ้ำ 3 รายการ`

## Step 2 — Extract
The main agent does items 1–3 of `2-extract.md` itself (find documents/page ranges, column headers, existing IDs), then:
1. **Backbone first** — the main agent extracts `04 Main Flow` (ordered Step list with existing IDs/`NEW-n`) so all groups use the same Step names and order
2. **Round 1 (parallel)** — send the Main Flow backbone with every prompt:
   - Group A: 01 / 02 / 03 / 05 / 06 / 07 / 08 / 09
   - Group B: 11 Process Step Detail + 11 Screen Sequence
   - Group C: 12 Document Matrix + 13 LAW Transition
3. **Round 2** — after merging round 1: Group D: 14–15 Test Case / Test Steps + 17 Test Data (needs Decisions, screens, and Transitions from round 1 — pass the merged file path)
4. The main agent merges into `A{nn}_extract.md` per the `2-extract.md` structure, completes item 6 (compare with draft) and item 7 (questions), then goes to Checkpoint 1

## Step 3 — Verify vs code
1. The main agent builds/updates the code map (`code-graph.md` item 2) **before** dispatching — sub-agents may only use read-only `graphify query/explain/path/god-nodes`
2. Split screen-level items in `A{nn}_extract.md` by Flow (or by screen group if one Flow has many screens) — 1 sub-agent per group, each doing items 2–5 of `3-verify.md` for its group only
3. Components/files shared across Flows (e.g. status enums, layout, permissions) — assign to **only the first group**, and tell the others not to recheck
4. "พบในโค้ดแต่ไม่พบในเล่ม" — the main agent dedupes when merging (several groups may find the same thing)
5. The main agent merges into `A{nn}_verify.md` per item 6 of `3-verify.md` and reports per item 7

## Step 6 — Playwright tests
The main agent does items 1–3 of `6-playwright.md` itself (check existing tests, gather user flows, prepare to run), then:
1. **Extracting screen details (item 4)** — the main agent starts the prototype **once** on one port and passes the URL to 1 sub-agent per Flow (sub-agents must not start their own servers). Each uses its own browser context and sets initial state itself via the prototype's mechanisms, writing to a part file → the main agent merges into `A{nn}_screens.md` and stops the server
2. **⏸ Checkpoint 3** — main agent does it per item 5
3. **Write tests (item 6)** — the main agent writes the shared parts first: `playwright.config.ts`, `e2e/helpers/screen.ts`, `package.json`, `.gitignore`, and installs Playwright (item 7.1) — then 1 sub-agent per Flow writes `e2e/flows/<flow-id>-….spec.ts`, **its own file only** (never edit helpers/config — request extra functions from the main agent)
4. **Per-file runs (items 7.2–7.3)** — each sub-agent runs only its own spec until it passes (use `--workers=1` to avoid server contention; let Playwright start the server via `webServer` + `reuseExistingServer`). To switch to `test.fixme`, send the reason and source back — **the main agent confirms** it is a genuine prototype-vs-flow mismatch, not a test problem
5. **Full run (items 7.4–7.6)** — the main agent runs the whole suite itself, including `--repeat-each=2` and the repo's existing tests, checks that style/`describe`/`test` naming is consistent across files, then saves `A{nn}_playwright.md` per item 8

## Asking the user (step 0)
Ask once per run after the readiness check (AskUserQuestion), with a rough size of the work (number of documents/pages related to the Activity if known, whether code exists):
"จะให้แบ่งงานให้ผู้ช่วยหลายตัว (sub-agent) ทำพร้อมกันไหม? — เร็วขึ้นเมื่องานใหญ่ แต่ใช้โควตามากขึ้น"
- `ใช้ผู้ช่วยทำพร้อมกัน` — recommended when many documents/dozens of pages, several Flows, or many screens (append "(แนะนำ)" to this option when the condition holds)
- `ทำทีละขั้นคนเดียว` — recommended for small work (append "(แนะนำ)" when the condition above doesn't hold)

The answer applies to steps 2, 3 and 6 for the whole run; don't ask again (`/ecmis <no.> test` also asks in step 0).
