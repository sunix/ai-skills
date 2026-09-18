#!/bin/sh
# Review remarks live in the prose itself, as `> @claude …` blockquotes. They are working notes,
# not content, so none may reach the default branch — this fails while any remain.
#
#   ./scripts/check-review-markers.sh [file-to-skip ...]
#
# Remarks shown as examples inside a fenced code block do not count, so documentation that explains
# the convention passes on its own. Pass a path to skip a file that shows one outside a fence. Set
# REVIEW_MARKER to use another handle, e.g. REVIEW_MARKER=@me.
set -eu

# Spelled in two pieces by default so this script never matches itself.
marker="${REVIEW_MARKER:-@''claude}"
marker=$(printf '%s' "$marker" | tr -d "'")

excludes=""
for skip in "$@"; do
    excludes="$excludes --exclude=$skip"
done

# shellcheck disable=SC2086  # unquoted on purpose: the exclude list has to word-split
candidates=$(grep -rIl --exclude-dir=.git $excludes "^> $marker" . || true)

found=""
# read line by line rather than iterating a split string, so a path with a space survives
while IFS= read -r file; do
    [ -n "$file" ] || continue
    hits=$(awk -v marker="> $marker" -v file="$file" '
        /^```/ { fenced = !fenced; next }
        !fenced && index($0, marker) == 1 { printf "%s:%d:%s\n", file, FNR, $0 }
    ' "$file")
    if [ -n "$hits" ]; then
        found="$found$hits
"
    fi
done <<CANDIDATES
$candidates
CANDIDATES

if [ -n "$found" ]; then
    echo "Unaddressed review annotations:"
    printf '%s' "$found" | sed 's/^/  /'
    echo
    echo "Answer each one in the prose and delete the annotation."
    exit 1
fi

echo "No review annotations left."
