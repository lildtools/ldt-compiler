#!/bin/sh

main() {
    scriptName=$1
    scriptFile=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../main/sh/$scriptName.sh)
    scriptTmp=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../)

    if [ ! -d "$scriptTmp/" ]; then mkdir "$scriptTmp/"; fi
    if [ ! -d "$scriptTmp/out/" ]; then mkdir "$scriptTmp/out/"; fi

    if [ "$LDT_TEST_UNIT_DEBUG_MODE" = "true" ]; then
        printf "$scriptName.test...\n"
        printf "  test created: $(date +"%Y-%m-%d %H:%M:%S.%3N")\n"
        printf "  test file: $scriptFile\n"
        printf "  -- start: $scriptName.test\n"
        printf "  -----\n"
    fi
    testFile=$scriptTmp/out/$scriptName.out
    testFileRoot=$(dirname $testFile)
    testFileName=$(basename $testFile)
    testFileMain="${testFileName%.*}"
    mkdir -p $testFileRoot
    cp $scriptFile $testFile
    echo $testFileMain >>$testFile
    if [ "$LDT_TEST_UNIT_DEBUG_MODE" = "true" ]; then
        /bin/bash $testFile
    else
        /bin/bash $testFile >/dev/null
    fi
    testResult=$?
    if [ "$LDT_TEST_UNIT_DEBUG_MODE" = "true" ]; then
        printf "  -----\n"
        printf "  -- done: $scriptName.test\n"
        printf "  test finished: $(date +"%Y-%m-%d %H:%M:%S.%3N")\n"
    fi

    if [ $testResult -ne 0 ]; then
        printf "%-75s: failed.\n" "$scriptName.test"
    else
        printf "%-75s: ok.\n" "$scriptName.test"
    fi
}

main $1
