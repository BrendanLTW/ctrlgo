---
description: Implement the next unchecked task in docs/PLAN.md
---

Do the next task from `docs/PLAN.md`, following `CLAUDE.md`.

1. **Find it.** Take the first line in `docs/PLAN.md` that starts with `- [ ]`.
   - If it's a **Gate**, don't implement anything. Restate the gate, say what evidence it needs, and stop until I confirm it passed.
   - If it's the first task of a new phase, check the previous phase's gate (if it has one) is ticked. If not, stop and say so.
   - If it already has a blocker note under it, show the blocker and stop.

2. **Restate it.** Show the task ID, its text, its "Done when", and the PRD (FR/US) and DESIGN sections it touches. Read those sections, and for a screen, the artboard on the design canvas, before writing code.

3. **Implement it with tests.** Respect the layer, theme and secrets rules in `CLAUDE.md`. Add the tests the "Done when" and the testing rules call for. Run codegen if you touched annotated code.

4. **Run the checks** from `CLAUDE.md`. All must be green and the "Done when" must pass.
   - If you can't get there, write `  Blocked: <reason and what's needed>` under the task in `docs/PLAN.md`, leave it unchecked, and stop.

5. **Tick the box** (`- [x]`) in `docs/PLAN.md`.

6. **Summarise**, briefly:
   - What changed (files, in one line each)
   - How the "Done when" was verified (commands and results)
   - Non-obvious code explained: why it's done that way, as I'd explain it in an interview
   - Anything I should know: shortcuts, risks, decisions, doc conflicts
   - The proposed commit message: `<task ID> <short title>`, e.g. `0.3 Theme tokens`

7. **Stop.** Don't commit until I approve, and don't start the next task.
