#!/bin/sh

main() {
    ldt_compiler_loadContext
    ldt_compiler_parseArgs $*
    ldt_compiler_validateArgs
    ldt_compiler_routeTask
    return $ldt_compiler_exitCode
}
ldt_compiler_printUsage() {
    $ldt_compiler_console "USAGE:"
    $ldt_compiler_console "  ldt-compiler <logTrace | logDebug | logInfo | logWarn | logError >[logMessage]"
    $ldt_compiler_console "  "
    $ldt_compiler_console "  tasks:"
    $ldt_compiler_console "    logTrace - prints the log message to the console with trace log level"
    $ldt_compiler_console "    logDebug - prints the log message to the console with degub log level"
    $ldt_compiler_console "    logInfo - prints the log message to the console with information log level"
    $ldt_compiler_console "    logWarn - prints the log message to the console with warning log level"
    $ldt_compiler_console "    logError - prints the log message to the console with error log level"
    $ldt_compiler_console "  "
    $ldt_compiler_console "  params:"
    $ldt_compiler_console "    logMessage - log message, the message to print"
    $ldt_compiler_console "  "
}
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
ldt_compiler_parseArgs() {
    ldt_compiler_cmd=$1

    shift
    ldt_compiler_args=$*

    if [ "$ldt_compiler_logLevel_current" = "" ]; then
        ldt_compiler_logLevel_current=$ldt_compiler_logLevel_default
    fi
}
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
ldt_compiler_routeTask() {
    if [ "$ldt_compiler_cmd" = "logDebug" ]; then ldt_compiler_logDebug $ldt_compiler_args; fi
    if [ "$ldt_compiler_cmd" = "logError" ]; then ldt_compiler_logError $ldt_compiler_args; fi
    if [ "$ldt_compiler_cmd" = "logInfo" ]; then ldt_compiler_logInfo $ldt_compiler_args; fi
    if [ "$ldt_compiler_cmd" = "logTrace" ]; then ldt_compiler_logTrace $ldt_compiler_args; fi
    if [ "$ldt_compiler_cmd" = "logWarn" ]; then ldt_compiler_logWarn $ldt_compiler_args; fi
}
main $*
