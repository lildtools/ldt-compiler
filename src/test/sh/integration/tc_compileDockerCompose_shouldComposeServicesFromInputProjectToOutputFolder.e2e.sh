#!/bin/bash

main() {
    cmd="$1 -t compose"
    if [ "$LDT_COMPILER_DEBUG_MODE" = "true" ]; then
        $cmd
    fi
    result=$($cmd | grep TODO:)
    if [ "$result" = "" ]; then exit 400; fi
    exit 0
}

main $1
