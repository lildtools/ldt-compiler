load() {
    ## load:variables
    ldtc_chmod=700
    ldtc_cmd=$1
    ldtc_fileName=
    ldtc_input=
    ldtc_me=$(whoami)
    ldtc_output=
    ldtc_target=bash-application
    ldtc_workindDir=$PWD
    shift

    ## load:environment
    if [ -f $ldtc_workindDir/.env ]; then
        export $(cat $ldtc_workindDir/.env | xargs)
    fi
    if [ -f $ldtc_workindDir/ldtc.env ]; then
        export $(cat $ldtc_workindDir/ldtc.env | xargs)
    fi
    if [ -f $ldtc_workindDir/ldt-compiler.env ]; then
        export $(cat $ldtc_workindDir/ldt-compiler.env | xargs)
    fi

    ## load:logger
    logger="eval echo"
    if [ ! "$(command -v ldtl)" = "" ]; then logger=ldtl; fi
    if [ ! "$(command -v $ldtl)" = "" ]; then logger=$ldtl; fi
    if [ ! "$(command -v ldt-logger)" = "" ]; then logger=ldt-logger; fi
    if [ ! "$(command -v ldtLogger)" = "" ]; then logger=ldtLogger; fi
    LDT_LOGGER_PREFIX="[LDTC]"
    if [ "$LDT_COMPILER_DEBUG_MODE" = "true" ]; then
        LDT_LOGGER_LEVEL=DEBUG
    else
        LDT_LOGGER_LEVEL=WARN
    fi

    ## load:target
    if [ ! "$LDT_COMPILER_TARGET" = "" ]; then
        ldtc_target=$LDT_COMPILER_TARGET
    fi

    ## load:in-out
    if [ ! "$LDT_COMPILER_INPUT" = "" ]; then
        ldtc_input=$LDT_COMPILER_INPUT
    fi
    if [ ! "$LDT_COMPILER_OUTPUT" = "" ]; then
        ldtc_output=$LDT_COMPILER_OUTPUT
    fi
    if [ ! "$LDT_COMPILER_FILE_NAME" = "" ]; then
        ldtc_fileName=$LDT_COMPILER_FILE_NAME
    fi
    if [ ! "$LDT_COMPILER_CHMOD" = "" ]; then
        ldtc_chmod=$LDT_COMPILER_CHMOD
    fi
}
