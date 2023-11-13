ldt_compiler_parseArgs() {
    ldt_compiler_cmd=$1

    shift
    ldt_compiler_args=$*

    if [ "$ldt_compiler_logLevel_current" = "" ]; then
        ldt_compiler_logLevel_current=$ldt_compiler_logLevel_default
    fi
}
