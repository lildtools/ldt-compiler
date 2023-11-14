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
parse() {
    args=()

    for arg in "$@"; do
        case "$arg" in
        --debug)
            LDT_COMPILER_DEBUG_MODE=true
            ;;
        -t | --target)
            LDT_COMPILER_TARGET_FLAG=true
            ;;
        *)
            if [ "$LDT_COMPILER_TARGET_FLAG" = "true" ]; then
                LDT_COMPILER_TARGET_FLAG=false
                LDT_COMPILER_TARGET=$arg
                continue
            fi
            args+=($arg)
            ;;
        esac
    done
}
load() {
    ldtc_cmd=$1
    ldtc_me=$(whoami)
    ldtc_target=bash-application
    ldtc_workindDir=$PWD

    if [ -f $ldtc_workindDir/.env ]; then
        export $(cat $ldtc_workindDir/.env | xargs)
    fi
    if [ -f $ldtc_workindDir/ldtc.env ]; then
        export $(cat $ldtc_workindDir/ldtc.env | xargs)
    fi
    if [ -f $ldtc_workindDir/ldt-compiler.env ]; then
        export $(cat $ldtc_workindDir/ldt-compiler.env | xargs)
    fi

    LDT_LOGGER_PREFIX="[LDTC]"
    if [ "$LDT_COMPILER_DEBUG_MODE" = "true" ]; then
        LDT_LOGGER_LEVEL=DEBUG
    else
        LDT_LOGGER_LEVEL=WARN
    fi

    if [ ! "$LDT_COMPILER_TARGET" = "" ]; then
        ldtc_target=$LDT_COMPILER_TARGET
    fi
}
validate() {
    if ! command -v ldt-logger &>/dev/null; then logger="eval echo"; fi

    if [ "$ldtc_cmd" = "" ]; then ldtc_cmd=compile; fi
    if [ "$ldtc_cmd" = "-h" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "--help" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "-u" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "--usage" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "usage" ]; then ldtc_target=print; fi

    if [ ! "$ldtc_cmd" = "usage" ] &&
        [ ! "$ldtc_cmd" = "compile" ]; then
        $logger logError "Unknown command!"
        $logger logDebug "-- cause: ldtc_cmd=$ldtc_cmd"
        exit 400
    fi

    if [ ! "$ldtc_target" = "print" ] &&
        [ ! "$ldtc_target" = "bash-app" ] &&
        [ ! "$ldtc_target" = "bash-application" ] &&
        [ ! "$ldtc_target" = "compose" ] &&
        [ ! "$ldtc_target" = "docker-compose" ] &&
        [ ! "$ldtc_target" = "nginx" ] &&
        [ ! "$ldtc_target" = "nginx-config" ]; then
        $logger logError "Unknown target!"
        $logger logDebug "-- cause: ldtc_target=$ldtc_target"
        exit 400
    fi

    if [ "$ldtc_workindDir" = "" ]; then
        $logger logError "Working directory is required!"
        $logger logDebug "-- cause: ldtc_workindDir=$ldtc_workindDir"
        exit 404
    fi
    if [ ! -d "$ldtc_workindDir" ]; then
        $logger logError "Working directory is invalid!"
        $logger logDebug "-- cause: ldtc_workindDir=$ldtc_workindDir"
        exit 500
    fi
}
run() {
    if [ "$ldtc_cmd" = "usage" ]; then
        if [ "$ldtc_target" = "print" ]; then
            doPrintUsage
        fi
    fi
    if [ "$ldtc_cmd" = "compile" ]; then
        if [ "$ldtc_target" = "bash-app" ]; then
            doCompileBashApplication
        fi
        if [ "$ldtc_target" = "bash-application" ]; then
            doCompileBashApplication
        fi
        if [ "$ldtc_target" = "compose" ]; then
            doCompileDockerCompose
        fi
        if [ "$ldtc_target" = "docker-compose" ]; then
            doCompileDockerCompose
        fi
        if [ "$ldtc_target" = "nginx" ]; then
            doCompileNginxConf
        fi
        if [ "$ldtc_target" = "nginx-config" ]; then
            doCompileNginxConf
        fi
    fi
}
doPrintUsage() {
echo "=============================================
USAGE:
  ldtc <task> [args]

tasks:
  task1  -  some task
  task2  -  some task
  task3  -  some task

args:
  arg1   - some arg
  arg2   - some arg
  arg3   - some arg
"
}
doCompileDockerCompose() {
    $logger logDebug "running..."
    $logger logDebug "-- ldtc_cmd=$ldtc_cmd"
    $logger logDebug "-- ldtc_me=$ldtc_me"
    $logger logDebug "-- ldtc_target=$ldtc_target"
    $logger logDebug "-- ldtc_workindDir=$ldtc_workindDir"
    $logger logDebug "compile: Docker-Compose..."

    echo "TODO: doCompileDockerCompose"

    $logger logDebug "compiled."
    $logger logDebug "done."
}
doCompileBashApplication() {
    $logger logDebug "running..."
    $logger logDebug "-- ldtc_cmd=$ldtc_cmd"
    $logger logDebug "-- ldtc_me=$ldtc_me"
    $logger logDebug "-- ldtc_target=$ldtc_target"
    $logger logDebug "-- ldtc_workindDir=$ldtc_workindDir"
    $logger logDebug "compile: BashApplication..."

    echo "TODO: doCompileBashApplication"

    $logger logDebug "compiled."
    $logger logDebug "done."
}
doCompileNginxConf() {
    $logger logDebug "running..."
    $logger logDebug "-- ldtc_cmd=$ldtc_cmd"
    $logger logDebug "-- ldtc_me=$ldtc_me"
    $logger logDebug "-- ldtc_target=$ldtc_target"
    $logger logDebug "-- ldtc_workindDir=$ldtc_workindDir"
    $logger logDebug "compile: BashApplication..."

    echo "TODO: doCompileNginxConf"

    $logger logDebug "compiled."
    $logger logDebug "done."
}
main $*
