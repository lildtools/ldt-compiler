#!/bin/sh

main() {
    scriptName=$1
    scriptFile=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../main/sh/$scriptName.sh)

    if [ "$LDT_COMPILER_DEBUG_MODE" = "true" ]; then
        printf "$scriptName.test...\n"
        printf "  test created: $(date +"%Y-%m-%d %H:%M:%S.%3N")\n"
        printf "  test file: $scriptFile\n"
        printf "  -- start: $scriptName.test\n"
    fi

    /bin/bash $scriptFile
    testResult=$?

    if [ "$LDT_COMPILER_DEBUG_MODE" = "true" ]; then
        printf "  -- done: $scriptName.test\n"
        printf "  test finished: $(date +"%Y-%m-%d %H:%M:%S.%3N")\n"
    fi
    if [ $testResult -ne 0 ]; then
        printf "%-45s: failed.\n" "$scriptName.test"
    else
        printf "%-45s: ok.\n" "$scriptName.test"
    fi
}

main $1
