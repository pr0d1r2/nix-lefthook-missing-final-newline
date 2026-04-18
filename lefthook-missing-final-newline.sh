# shellcheck shell=bash
# Lefthook-compatible missing final newline checker.
# Usage: lefthook-missing-final-newline file1 [file2 ...]
# NOTE: sourced by writeShellApplication — no shebang or set needed.

if [ $# -eq 0 ]; then
    exit 0
fi

files=()
for f in "$@"; do
    [ -f "$f" ] || continue
    files+=("$f")
done

if [ ${#files[@]} -eq 0 ]; then
    exit 0
fi

found=0
for f in "${files[@]}"; do
    if [ -s "$f" ] && [ "$(tail -c 1 "$f" | wc -l)" -eq 0 ]; then
        echo "$f: missing final newline"
        found=1
    fi
done

exit "$found"
