ldt_compiler_validateArgs() {
    if [ ! "$ldt_compiler_logLevel_default" = "TRACE" ] &&
        [ ! "$ldt_compiler_logLevel_default" = "DEBUG" ] &&
        [ ! "$ldt_compiler_logLevel_default" = "INFO" ] &&
        [ ! "$ldt_compiler_logLevel_default" = "WARN" ] &&
        [ ! "$ldt_compiler_logLevel_default" = "ERROR" ]; then
        ldt_compiler_logFatal "default-logLevel ('$ldt_compiler_logLevel_default') is invalid!"
        ldt_compiler_logFatal "logLevels = TRACE|DEBUG|INFO|WARN|ERROR"
        ldt_compiler_exitCode=500
        return
    fi

    if [ ! "$ldt_compiler_logLevel_current" = "TRACE" ] &&
        [ ! "$ldt_compiler_logLevel_current" = "DEBUG" ] &&
        [ ! "$ldt_compiler_logLevel_current" = "INFO" ] &&
        [ ! "$ldt_compiler_logLevel_current" = "WARN" ] &&
        [ ! "$ldt_compiler_logLevel_current" = "ERROR" ]; then
        ldt_compiler_logFatal "current-logLevel ('$ldt_compiler_logLevel_current') is invalid!"
        ldt_compiler_logFatal "logLevels = TRACE|DEBUG|INFO|WARN|ERROR"
        ldt_compiler_exitCode=500
        return
    fi

    if [ "$ldt_compiler_cmd" = "" ]; then
        ldt_compiler_logError "cmd (arg1) is required!"
        ldt_compiler_exitCode=500
        return
    fi

    if [ ! "$ldt_compiler_cmd" = "logTrace" ] &&
        [ ! "$ldt_compiler_cmd" = "logDebug" ] &&
        [ ! "$ldt_compiler_cmd" = "logInfo" ] &&
        [ ! "$ldt_compiler_cmd" = "logWarn" ] &&
        [ ! "$ldt_compiler_cmd" = "logError" ]; then
        ldt_compiler_logFatal "cmd ('$ldt_compiler_cmd') is invalid!"
        ldt_compiler_logFatal "commands = logTrace|logDebug|logInfo|logWarn|logError"
        ldt_compiler_exitCode=400
        return
    fi

    if [ "$ldt_compiler_args" = "" ]; then
        ldt_compiler_logError "args (arg*) is required"
        ldt_compiler_exitCode=404
        return
    fi
}
