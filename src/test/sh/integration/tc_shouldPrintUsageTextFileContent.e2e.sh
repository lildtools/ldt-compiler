#!/bin/bash

main() {
    cmd="$1 --usage"
    if [ "$LDT_TEST_E2E_DEBUG_MODE" = "true" ]; then $cmd; fi

    result=$($cmd | grep USAGE:)

    if [ "$result" = "" ]; then exit 400; fi
    exit 0
}

main $1
