#!/bin/bash

main() {
    testCaseName=$1
    testCaseShort="${testCaseName%.*}"
    testCaseFile=$(realpath $(dirname "${BASH_SOURCE[0]}")/$testCaseName)
    versionFile=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../VERSION)
    VERSION=$(cat $versionFile)

    cmd=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../dist/$DISTNAME-$VERSION.sh)

    if [ "$LDT_TEST_E2E_DEBUG_MODE" = "true" ]; then
        printf "$testCaseShort...\n"
        printf "  e2e created: $(date +"%Y-%m-%d %H:%M:%S.%3N")\n"
        printf "  e2e file: $testCaseFile\n"
        printf "  -- cmd: $cmd\n"
        printf "  -- start: $testCaseShort\n"
        printf "  -----\n"
    fi
    /bin/bash $testCaseFile "$cmd"
    testResult=$?
    if [ "$LDT_TEST_E2E_DEBUG_MODE" = "true" ]; then
        printf "  -----\n"
        printf "  -- done: $testCaseShort\n"
        printf "  e2e finished: $(date +"%Y-%m-%d %H:%M:%S.%3N")\n"
    fi

    if [ $testResult -ne 0 ]; then
        printf "%-75s: failed.\n" "$testCaseShort"
    else
        printf "%-75s: ok.\n" "$testCaseShort"
    fi
}

main $1
