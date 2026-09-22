# Code map (graphify) — used in steps 3 and 6

Use **graphify** to build a code map (knowledge graph) of the prototype, to quickly find files/functions/screens related to the Activity and see what calls what, before opening the actual files.

## Principles
- graphify is a **locator**, not a data source — every recorded result must still come from opening the actual file and be cited as `path/ไฟล์:บรรทัด`; never cite graph results directly
- Use only code-structure mode (`--code-only`) — fast, no API key, no extra AI cost
- **Never write anything into the prototype** — the map lives only at `work/graph/graphify-out/` in the ecmis-trace project (never run `graphify update` or `/graphify` in the prototype folder, as that creates `graphify-out/` in that repo)
- Command: `graphify` — if not found (common on Windows), use `"<python>" -m graphify`

## 1. Check graphify is available
Once per run (step 0) when `input/code/` is not empty:
```
graphify --help
```
- Works → pass
- Not found → ask the user (AskUserQuestion): "ยังไม่ได้ติดตั้งตัวช่วยอ่านโค้ด (graphify) ซึ่งช่วยให้หาโค้ดที่เกี่ยวข้องได้เร็วและครบขึ้น ติดตั้งให้เลยไหม?" — `ติดตั้งเลย (แนะนำ)` / `ไม่ติดตั้ง อ่านโค้ดแบบปกติ`
  - Install → run `"<python>" -m pip install graphifyy` (same `python` used for the markitdown check), then re-check. If it fails, say so briefly and continue reading code normally (don't stop)
  - Don't install → read code normally and don't ask again this run

## 2. Build/update the map
Run at the ecmis-trace project root before step 3 (and before step 6 if jumping in via `/ecmis <no.> test`) — `<CODE_ROOT>` = folder in `input/code/` or the repo path that a file in `input/code/` points to
```
graphify extract "<CODE_ROOT>" --code-only --out work/graph
```
- No need to ask the user — first time builds, later runs update only changed files
- If `input/code/` has multiple repos, use one folder per repo, e.g. `--out work/graph/<repo name>`
- If it fails, say so briefly and continue reading code normally
- Report progress, e.g. `ขั้น 3/6 สร้างแผนที่โค้ด…`

## 3. Use the map to find code
Add `--graph work/graph/graphify-out/graph.json` to every command (per-repo: point to that repo's folder)

| Need | Command |
|---|---|
| Find code for a screen/button/status | `graphify query "<Page Code / screen name / keyword>" --graph …` |
| See what something connects to (e.g. screen → validation) | `graphify explain "<component/function name>" --graph …` |
| Path between two points (e.g. screen A → screen B) | `graphify path "<A>" "<B>" --graph …` |
| Hub files (routes, store, status enums) | `graphify god-nodes --graph …` |

- Each result node has `src=<file> loc=L<line>` (path relative to `<CODE_ROOT>`) — use it to open the actual file
- If results are cut (`TRUNCATED`), narrow the query or add `--budget 4000`
- If not found in the map (e.g. text in HTML/JSON or strings in code), continue with a normal file search — **never conclude "ไม่พบในโค้ด" from the map alone**
