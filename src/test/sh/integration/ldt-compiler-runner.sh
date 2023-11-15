#!/bin/bash

main() {
    testCaseName=$1
    testCaseShort="${testCaseName%.*}"
    testCaseFile=$(realpath $(dirname "${BASH_SOURCE[0]}")/$testCaseName)
    versionFile=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../VERSION)
    VERSION=$(cat $versionFile)

    ldtc=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../dist/ldt-compiler-$VERSION.sh)

    if [ "$LDT_COMPILER_DEBUG_MODE" = "true" ]; then
        printf "$testCaseShort...\n"
        printf "  e2e created: $(date +"%Y-%m-%d %H:%M:%S.%3N")\n"
        printf "  e2e file: $testCaseFile\n"
        printf "  -- ldtc: $ldtc\n"
        printf "  -- start: $testCaseShort\n"
    fi

    /bin/bash $testCaseFile "$ldtc"
    testResult=$?

    if [ "$LDT_COMPILER_DEBUG_MODE" = "true" ]; then
        printf "  -- done: $testCaseShort\n"
        printf "  e2e finished: $(date +"%Y-%m-%d %H:%M:%S.%3N")\n"
    fi
    if [ $testResult -ne 0 ]; then
        printf "%-80s: failed.\n" "$testCaseShort"
    else
        printf "%-80s: ok.\n" "$testCaseShort"
    fi
}

main $1
