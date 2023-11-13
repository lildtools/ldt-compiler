#!/bin/bash

#<include ldt-logger>
logger="eval ldt-logger"

main() {
    parse $*
    load "${args[@]}"
    validate
    run
    if [ $? -ne 0 ]; then exit 500; fi
    exit 0
}
