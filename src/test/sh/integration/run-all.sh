#!/bin/bash

main() {
    testRunner="/bin/bash"
    testPath=$(realpath $(dirname "${BASH_SOURCE[0]}")/)
    testEnv=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../resources/ldtc-test.env)
    testCase=$1

    if [ -f $testEnv ]; then export $(cat $testEnv | xargs); fi

    if [ ! "$testCase" = "" ]; then
        $testRunner $testPath/ldt-compiler.e2e.sh "$testCase"
    else
        $testRunner $testPath/ldt-compiler.e2e.sh "printUsage_shouldPrintUsageTextFileContent"
        $testRunner $testPath/ldt-compiler.e2e.sh "compileBashApplication_shouldCompileFromInputProjectToOutputFolder"
        $testRunner $testPath/ldt-compiler.e2e.sh "compileDockerCompose_shouldComposeServicesFromInputProjectToOutputFolder"
        $testRunner $testPath/ldt-compiler.e2e.sh "compileNginxConf_shouldGenerateConfigIntoOutputFolder"
    fi
}

main $1
