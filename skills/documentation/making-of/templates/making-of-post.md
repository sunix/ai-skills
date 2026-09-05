# <Milestone or theme>: <subtitle stating what shipped or what was learned>

<!-- One post per milestone (or milestone group), stored as doc/making-of/NN-slug.md and
linked from the root MAKING-OF.md index. Same voice and rules as the main file: first
person, past tense, honest, concrete. -->

## <Point 1 — one feature or fix, stated as a claim or event>

*Commit `<type(scope): title identical to this heading>`. Files to open: [`Foo.java`](../../path/to/Foo.java),
[`FooTest.java`](../../path/to/FooTest.java).*

<!-- One commit per point, titled like the heading, so `git log --oneline` reads as this
post's table of contents and the commit's diff sits next to the section. The italic line
above names it and links the two to five files to have open; the prose below points at the
method or lines, not just the file. If two points must land in one commit, or a point has no
commit (design discussion, test-only check), say so here instead of faking a split.

Goal: the class/annotation/fixture the point is about, the test method itself, and the
actual red test-runner output it produced when TDD wrote it first — same test the proof
below re-runs green. Code before command output, always: a runner line with no snippet
above it proves nothing to the reader. What was built: the load-bearing snippet(s) and why
they're shaped that way. Proof: the same test, now green. A post covering several distinct
points repeats this goal -> built -> proof cycle once per point instead of merging them into
one pass — link PRs/issues, quote numbers throughout. -->

## <Point 2 — another feature or fix>

<!-- Same shape as above: goal (+ red run), built, proof (+ green run). If this point's
test happened to already pass before the real implementation existed, say so plainly rather
than presenting that accidental pass as proof. -->

## <Dead end worth recording>

<!-- Dead ends get their own sections — they are the content, not noise. Say how far the
trail was followed and why it stopped. -->

## <What's next>

<!-- Optional: the open questions this post hands to the next one. -->
