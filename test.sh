#! /usr/bin/env bash
################################################################################
# test.sh
# -----------------
# Checks all bashscripts for errors
################################################################################
set -eo pipefail

ERRORS=()

# Find all executables and run `shellcheck`
for f in $(find . -type f -name '*.sh' -o -name '.*' -not -name '*.git*' | sort -u); do
    if file "$f" | grep --quiet shell; then
        {
            shellcheck "$f" && echo "[OK]: sucessfully linted $f"
        } || {
            # Add to errors
            ERRORS+=("$f")
        }
    fi
done

if [ ${#ERRORS[@]} -eq 0 ]; then
    echo "No errors, hooray"
else
    echo "These files failed shellcheck: ${ERRORS[*]}"
    exit 1
fi