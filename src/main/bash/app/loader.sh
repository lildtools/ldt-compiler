ldt_compiler_loadContext() {
    ldt_compiler_args=()
    ldt_compiler_cmd=""
    ldt_compiler_console=echo
    ldt_compiler_exitCode=0
    ldt_compiler_logLevel=""
    ldt_compiler_logLevel_current=$ldt_compiler_LOGLEVEL
    ldt_compiler_logLevel_default=ERROR
    ldt_compiler_logMessage=""
    ldt_compiler_logSeparator="---"
    ldt_compiler_now=$(date +"%Y-%m-%d %H:%M:%S.%3N")
    ldt_compiler_prefix="[LDT]"
}
