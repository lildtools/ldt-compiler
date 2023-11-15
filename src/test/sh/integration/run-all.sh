#!/bin/bash

main() {
    testRunner="/bin/bash"
    testPath=$(realpath $(dirname "${BASH_SOURCE[0]}")/)
    testEnv=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../resources/ldtc-test.env)
    testCase=$1

    if [ -f $testEnv ]; then export $(cat $testEnv | xargs); fi

    if [ "$testCase" = "" ]; then
        cmd=$(ls -a $testPath | grep .e2e.sh | xargs -I % echo "$testRunner $testPath/ldt-compiler-runner.sh \"%\" ; ")
        eval $cmd
    else
        $testRunner $testPath/ldt-compiler-runner.sh "$testCase"
    fi
}

main $1
