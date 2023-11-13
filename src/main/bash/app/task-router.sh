ldt_compiler_routeTask() {
    if [ "$ldt_compiler_cmd" = "logDebug" ]; then ldt_compiler_logDebug $ldt_compiler_args; fi
    if [ "$ldt_compiler_cmd" = "logError" ]; then ldt_compiler_logError $ldt_compiler_args; fi
    if [ "$ldt_compiler_cmd" = "logInfo" ]; then ldt_compiler_logInfo $ldt_compiler_args; fi
    if [ "$ldt_compiler_cmd" = "logTrace" ]; then ldt_compiler_logTrace $ldt_compiler_args; fi
    if [ "$ldt_compiler_cmd" = "logWarn" ]; then ldt_compiler_logWarn $ldt_compiler_args; fi
}
