#!/bin/bash

main() {
    cmd="$1 --version"
    versionFile=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../VERSION)
    VERSION=$(cat $versionFile)
    if [ "$LDT_COMPILER_DEBUG_MODE" = "true" ]; then
        $cmd
    fi
    result=$($cmd)
    if [ ! "$result" = "ldt-compiler v$VERSION" ]; then exit 400; fi
    exit 0
}

main $1
