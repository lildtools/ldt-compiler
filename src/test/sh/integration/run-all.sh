#!/bin/bash

main() {
    testRunner="/bin/bash"
    testPath=$(realpath $(dirname "${BASH_SOURCE[0]}")/)
    testEnv=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../resources/test-e2e.env)
    testCase=$1
    if [ -f $testEnv ]; then export $(cat $testEnv | xargs); fi

    if [ "$testCase" = "" ]; then
        cmd=$(ls -a $testPath | grep .e2e.sh | xargs -I % echo "$testRunner $testPath/e2e-runner.sh \"%\" ; ")
        eval $cmd
    else
        $testRunner $testPath/e2e-runner.sh "tc_$testCase.e2e.sh"
    fi
}

main $1
