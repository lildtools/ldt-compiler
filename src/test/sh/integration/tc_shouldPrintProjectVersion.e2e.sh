#!/bin/bash

main() {
    cmd="$1 --version"
    if [ "$LDT_TEST_E2E_DEBUG_MODE" = "true" ]; then $cmd; fi

    versionFile=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../VERSION)
    VERSION=$(cat $versionFile)
    result=$($cmd)

    if [ ! "$result" = "ldt-compiler v$VERSION" ]; then exit 400; fi
    exit 0
}

main $1
