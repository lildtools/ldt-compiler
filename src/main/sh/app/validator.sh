validate() {
    if ! command -v ldt-logger &>/dev/null; then logger="eval echo"; fi

    if [ "$ldtc_cmd" = "" ]; then ldtc_cmd=compile; fi
    if [ "$ldtc_cmd" = "-h" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "--help" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "-u" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "--usage" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "usage" ]; then ldtc_target=print; fi

    if [ ! "$ldtc_cmd" = "" ] &&
        [ ! "$ldtc_cmd" = "compile" ] &&
        [ ! "$ldtc_cmd" = "usage" ]; then
        $logger logError "Unknown command!"
        $logger logDebug "-- cause: ldtc_cmd=$ldtc_cmd"
        exit 400
    fi

    if [ ! "$ldtc_target" = "" ] &&
        [ ! "$ldtc_target" = "bash-app" ] &&
        [ ! "$ldtc_target" = "bash-application" ] &&
        [ ! "$ldtc_target" = "compose" ] &&
        [ ! "$ldtc_target" = "docker-compose" ] &&
        [ ! "$ldtc_target" = "print" ]; then
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
