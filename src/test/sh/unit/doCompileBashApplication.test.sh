#!/bin/bash

main() {
    runner=$(realpath $(dirname "${BASH_SOURCE[0]}")/test-runner.sh)

    /bin/bash \
        $runner \
        tasks/compile/doCompileBashApplication
}

main
