# pr-making-of — full agent instructions

Write (or revise) a pull-request body in the making-of voice.

---

## 0. Before you start

Read the diff. Read the conversation history. Then ask the author for anything you cannot recover from those two sources:

- What did you try first that did not work? (Even a sentence.)
- What does this PR deliberately leave undone? Any follow-up issues?
- Do you have real output — a test run, a command and its printed response — you can share?

Do not proceed to drafting until you have enough to write a goal, at least one reversal if the work had one, and either real proof or an explicit "no automated test exists".

If the `making-of` skill is installed, its style rules govern everywhere they apply. The rules in this file are the same ones; they are reproduced here so the skill works when `making-of` is not installed.

---

## 1. Size the shape to the diff

| Diff size | Shape |
|-----------|-------|
| ≤ ~5 files, straightforward change | One paragraph (lead) only |
| Multi-file or non-obvious change | Lead paragraph + labelled sections for reversals, proof, and parked work, each only when the diff warrants it |
| Large or multi-concern change | Lead paragraph + sections, possibly a brief "what this does not do" list at the end |

The lead paragraph **must stand alone**: a reviewer who reads only that paragraph should know what the PR does and why it exists. Write the lead first; add sections only when they carry weight the lead cannot.

Do not pad a small PR to fill a large template. Do not compress a large PR into a single flat paragraph.

---

## 2. Open on the goal

The first sentence names the user-visible problem or the need a reviewer should feel before reading the diff. Concrete is better than abstract. "The command crashed with a nil pointer when run against an empty repo" is a goal. "Refactor the command runner" is an inventory entry.

Banned openings:
- Any sentence that starts with the name of a file or a module ("Added `foo.ts`…", "Updated `bar.go`…").
- Any sentence that restates the PR title verbatim.
- Any sentence that begins with "This PR" — it is almost always an inventory entry in disguise.

---

## 3. Keep the reversals

A wrong first approach, a rename that had to be reverted, a diagnosis that was corrected after review — these are the highest-value lines in a PR body, because they are the only place that reasoning is ever written down.

If the author mentioned any of the following, surface them in the body:
- A first approach that was abandoned and why.
- An objection from review that turned out to be right.
- A path that looked correct and wasn't.

Do not smooth reversals away to make the work look cleaner. The reader who sees only the polished solution cannot learn from the path that was rejected.

---

## 4. Show proof

"Tested locally" proves nothing. Write:

- The specific test that was failing and is now green (trimmed to the relevant assertion).
- One sentence on what the failure before the fix looked like — what the test was actually checking.
- The real test-runner output, or the command run and what it printed.

Prefer output that a reviewer can reproduce. If CI ran, link the run. If there is no automated test, say so explicitly and show the manual command and its output instead.

---

## 5. Name what this does not do

Explicitly list:
- Work that was deliberately parked (and why, if the reason is not obvious).
- Known-open defects or edge cases that are out of scope.
- Follow-up issues, with links where they exist.

A reviewer who knows the scope of a PR cannot ask "why didn't you also fix X?" A reviewer who doesn't will.

---

## 6. Style rules (same register as making-of)

**First person, past tense.** "I tried X, it fell apart because Y." Never "this PR improves…" or "we are pleased to…"

**Honest, no marketing tone.** "The fix is a hack until issue #N is resolved" is correct. "A clean, robust solution" is not.

**Do not overstate the author's role.** When the work was pair-programmed or co-authored with an LLM, write "contributed to" or "helped shape", not "wrote" or "designed".

**No meta-narration.** The PR body never says "this PR covers…" or "I have written the following sections…" — just write the content.

**Concrete over abstract.** Link the actual issues and PRs. Quote the actual numbers. "Reduced cold-start time from 2.3 s to 0.4 s" beats "improved startup performance".

**No inventory openings.** A list of changed files is already in the diff. Open on what a reviewer should understand first; the inventory is never the opening.

---

## 7. Revising an existing body

When the author asks you to revise a body that already exists:

1. Prefix the revised body with a one-line note: "Rewritten after review:" or "Amended: [brief reason]."
2. Keep any context from the original that a reviewer who already read it would miss.
3. Do not silently replace the original as if it never existed — a reviewer who reviewed the earlier version should be able to see what changed.

---

## 8. Output format

Produce the body as a Markdown block ready to paste into the PR description field. Do not wrap it in a code fence unless the author asks for that. Do not include a title — that goes in the PR title field.

If sections are present, use `##` headings (not `###`) to match the GitHub PR interface. Keep heading text short and purposeful ("What this does not do", "How I know it works") — not generic labels ("Details", "Notes").
