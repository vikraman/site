#!/usr/bin/env bash

set -euo pipefail

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# preview re-renders: the watcher regenerates instead
preview=false
if [[ -n "${QUARTO_PROJECT_OUTPUT_DIR:-}" && -z "${QUARTO_PROJECT_RENDER_ALL:-}" ]]; then
    preview=true
fi

# typecheck and highlight each offering's literate agda
n=0
while IFS= read -r lib; do
    if $preview && [[ -d "$lib/../lectures" ]]; then
        continue
    fi
    n=$((n + 1))
    out="$tmp/$n"
    (cd "$lib" && agda --html --html-highlight=auto --html-dir="$out" Everything.agda)
    # only touch changed files or else preview loops
    mkdir -p "$lib/../lectures"
    rsync -rc --delete "$out/" "$lib/../lectures/"
done < <(find teaching -type d -name _agda)
