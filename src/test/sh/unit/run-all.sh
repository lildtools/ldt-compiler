#!/bin/bash

main() {
    testRunner="/bin/bash"
    testPath=$(realpath $(dirname "${BASH_SOURCE[0]}")/)
    testEnv=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../resources/ldtc-test.env)
    unit=$1

    if [ -f $testEnv ]; then export $(cat $testEnv | xargs); fi

    if [ ! "$unit" = "" ]; then
        $testRunner $testPath/$unit.test.sh
    else
        $testRunner $testPath/doPrintUsage.test.sh
        $testRunner $testPath/doCompileBashApplication.test.sh
        $testRunner $testPath/doCompileDockerCompose.test.sh
        $testRunner $testPath/doCompileNginxConf.test.sh
    fi
}

main $1
