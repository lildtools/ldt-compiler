#!/bin/bash

main() {
    testCase=$1
    testCaseFile=$(realpath $(dirname "${BASH_SOURCE[0]}")/tc_$testCase.e2e.sh)
    versionFile=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../VERSION)
    VERSION=$(cat $versionFile)

    ldtc=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../dist/ldt-compiler-$VERSION.sh)

    if [ "$LDT_COMPILER_DEBUG_MODE" = "true" ]; then
        printf "$testCase.e2e...\n"
        printf "  e2e created: $(date +"%Y-%m-%d %H:%M:%S.%3N")\n"
        printf "  e2e file: $testCaseFile\n"
        printf "  - ldtc: $ldtc\n"
        printf "  -- start: $testCase.e2e\n"
    fi

    /bin/sh $testCaseFile "$ldtc"
    testResult=$?

    if [ "$LDT_COMPILER_DEBUG_MODE" = "true" ]; then
        printf "  -- done: $testCase.e2e\n"
        printf "  e2e finished: $(date +"%Y-%m-%d %H:%M:%S.%3N")\n"
    fi
    if [ $testResult -ne 0 ]; then
        printf "%-80s: failed.\n" "$testCase.e2e"
    else
        printf "%-80s: ok.\n" "$testCase.e2e"
    fi
}

main $1
