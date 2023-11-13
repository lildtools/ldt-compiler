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

    if [ "$LDT_COMPILER_DEBUG_MODE" = "true" ]; then
        LDT_LOGGER_LEVEL=DEBUG
    else
        LDT_LOGGER_LEVEL=WARN
    fi

    if [ ! "$LDT_COMPILER_TARGET" = "" ]; then
        ldtc_target=$LDT_COMPILER_TARGET
    fi
}
