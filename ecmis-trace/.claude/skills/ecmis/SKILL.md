---
name: ecmis
description: End-to-end fill/update of the E-CMIS Master Activity Template one Activity at a time — convert source documents with markitdown, extract data, verify against code, update the Excel output, validate it, and create Playwright tests per user flow for prototypes that lack them, pausing for the user only at decision points. Use when the user runs /ecmis or asks to do/update an E-CMIS Activity (ทำ/อัปเดต Activity ของ E-CMIS).
argument-hint: <Activity no., e.g. 5> [test]
---

# /ecmis — Run an Activity through every step

Activity: **$ARGUMENTS**

Read the project `CLAUDE.md` fully before starting and follow its rules throughout.

**Skill folder (`<SKILL_DIR>`):** `${CLAUDE_SKILL_DIR}` — if this was not substituted with a real path, use `.claude/skills/ecmis` in the project if present, otherwise `~/.claude/skills/ecmis` (global install).
Python command: `python3` — on Windows, if `python3` is missing use `python` or `py -3`.
Users are both technical and non-technical — **talk in simple Thai**, don't explain commands/code behind the scenes.
Thai text in quotes/backticks in the skill files (option labels, progress messages, statuses, labels, markers) is literal — use it verbatim.

## Overview

```
0. Readiness check   → folders, template, documents, markitdown, graphify (if code), ask about sub-agents
1. Prepare docs      → references/1-prepare.md   (skip if documents unchanged)
2. Extract           → references/2-extract.md   ⏸ Checkpoint 1: user reviews data/answers questions
3. Verify vs code    → references/3-verify.md    (uses code map references/code-graph.md)
4. Update Excel      → references/4-update.md    ⏸ Checkpoint 2: user confirms adds/edits/deletes
5. Check output      → references/5-check.md
6. Playwright tests  → references/6-playwright.md (uses code map) ⏸ Checkpoint 3: user confirms before writing tests into the prototype
```

Steps 2, 3, 6 can be split across parallel sub-agents (Sonnet) if the user chose so in step 0 → `references/subagents.md` (the main agent always merges and writes final files; step 4 never uses sub-agents).

Before each step, read that step's reference file and follow it. (Any "stop and wait for the user before the next step" in a reference file is overridden by the checkpoints here — only truly stop at ⏸ checkpoints.)
Report short progress along the way, e.g. `ขั้น 2/6 สกัดข้อมูล Activity 5…`

## Step 0 — Readiness check

1. **Activity number** — first number in `$ARGUMENTS` (a trailing `test` = run only step 6). If `$ARGUMENTS` is empty, ask the user (if `work/docs/_index.md` exists, offer the Activities found in the documents as options).
2. **Folders and files** — check and create missing folders (`input/docs`, `input/code`, `work/docs`, `work/extract`, `output/backup`), then report as a ✅/❌ table:
   - `template/ECMIS_Master_Activity_Template_FlowScreenTrace.xlsx` must exist — otherwise stop
   - `input/docs/` must have at least 1 file — otherwise stop and tell the user to put the documents in this folder
   - If document files are misplaced (e.g. PDF/DOCX at the project root or directly in `input/`), offer to move them into `input/docs/` — ask first
   - `input/code/` may be empty, but say code verification in step 3 will be skipped
3. **markitdown** — run
   ```
   python3 "<SKILL_DIR>/scripts/convert_docs.py" . --check-deps
   ```
   - exit 0 → pass
   - exit 3 → JSON lists missing packages and the `python` used. Ask the user "ยังไม่ได้ติดตั้งตัวแปลงเอกสาร (markitdown) ติดตั้งให้เลยไหม?" If yes, run `"<python>" -m pip install <missing packages>` and re-check. If install fails, show the error and stop.
4. **graphify (code reading helper)** — only when `input/code/` is not empty: follow item 1 of `references/code-graph.md` (if missing, ask whether to install). Work continues without it, just reading code normally. Include the result in the ✅/❌ table.
5. **Sub-agents** — ask the user per "Asking the user (step 0)" in `references/subagents.md` whether to use multiple helpers in parallel — the answer applies to steps 2, 3, 6 for this whole run.

## Step 1 — Prepare docs
Follow `references/1-prepare.md` — the script converts only added/changed files. If nothing changed and `work/docs/_index.md` exists, say "เอกสารไม่เปลี่ยน ใช้ของเดิม" and go to step 2.

## Step 2 — Extract
- If `work/extract/A{nn}_extract.md` already exists **and** no document changed in step 1 → ask the user: ใช้ไฟล์เดิม (แนะนำ) / สกัดใหม่
- Follow `references/2-extract.md` — if sub-agents were chosen, split work per `references/subagents.md` section "Step 2"

**⏸ Checkpoint 1** — summarize in chat (don't make the user open files):
- Counts of Steps / screens / Transitions / Test Cases extracted
- Items that differ from the existing draft
- **All questions** as a numbered list with sources

Then ask the user (AskUserQuestion): `ไปต่อ` / `ขอตอบคำถามก่อน` / `หยุดไว้ก่อน`
- If the user answers questions → record the answers in the extract file under heading "คำตอบจากผู้ใช้" (mark as user answer, with date); they may then be used as a source. Then go to step 3.
- Unanswered questions become Open Issues in step 4.

## Step 3 — Verify vs code
- If `input/code/` is empty → ask the user: `ข้ามการเทียบโค้ด` / `หยุดเพื่อวางโค้ดก่อน`. If skipped, create `A{nn}_verify.md` stating "ข้ามการเทียบโค้ด — ไม่มี source code" and fill no screen-level data from code.
- Otherwise build/update the code map per `references/code-graph.md` item 2 (if graphify is available), then follow `references/3-verify.md` (if sub-agents were chosen, split per `references/subagents.md` section "Step 3"), then continue straight to step 4 (brief summary: ตรงเล่ม / ไม่ตรงเล่ม / ไม่พบในโค้ด).

## Step 4 — Update Excel
Follow `references/4-update.md` — **⏸ Checkpoint 2** is in this step (confirm the plan before writing the file).

## Step 5 — Check output
Follow `references/5-check.md` for this Activity, then continue to step 6.

## Step 6 — Playwright tests per user flow
Follow `references/6-playwright.md` on this Activity's prototype (code in `input/code/`) — use the code map (`references/code-graph.md`) to find test/route/screen files. If sub-agents were chosen, split per `references/subagents.md` section "Step 6".
- Prototype already has complete Playwright tests per user flow → report and skip
- Missing/incomplete → Extracting screen details per the prototype's user-flow documents, **⏸ Checkpoint 3** confirm before writing tests, then run until all pass
- No prototype (`input/code/` empty or step 3 skipped) → skip this step

## Final summary (in Thai)
- What was written per sheet, backup file name, check result (ผ่าน/ไม่ผ่าน)
- Playwright tests: files created in the prototype, run result (ผ่าน / fixme), screenshot location, places where the prototype doesn't match the flow (or why skipped)
- Newly opened Open Issues (the user needs to find answers)
- Pages read from images (if any), which should be human-reviewed
- **Stop.** Don't go to the next Activity until the user runs `/ecmis <next no.>`

## Resuming interrupted work
`/ecmis <same no.>` can be rerun — step 1 skips unchanged documents, step 2 offers to reuse the existing extract file, step 3 asks whether to reuse `A{nn}_verify.md` if it is newer than the extract file, step 6 continues only flows without tests.

To run only step 6 (e.g. Excel is done), the user runs `/ecmis <no.> test` — do step 0 then jump to step 6 (the Activity's extract file must already exist).
