#!/bin/bash

main() {
    testRunner="/bin/bash"
    testPath=$(realpath $(dirname "${BASH_SOURCE[0]}")/)
    testEnv=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../resources/test.env)
    unit=$1
    if [ -f $testEnv ]; then export $(cat $testEnv | xargs); fi

    if [ "$unit" = "" ]; then
        cmd=$(ls -a $testPath | grep .test.sh | xargs -I % echo "$testRunner $testPath/% ; ")
        eval $cmd
    else
        $testRunner $testPath/$unit.test.sh
    fi
}

main $1
