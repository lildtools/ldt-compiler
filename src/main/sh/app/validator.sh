validate() {
    ## validate:command
    if [ "$ldtc_cmd" = "" ]; then ldtc_cmd=compile; fi
    if [ "$ldtc_cmd" = "-h" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "--help" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "-u" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "--usage" ]; then ldtc_cmd=usage; fi
    if [ "$ldtc_cmd" = "usage" ]; then ldtc_target=print; fi
    if [ "$ldtc_cmd" = "-v" ]; then ldtc_cmd=version; fi
    if [ "$ldtc_cmd" = "--version" ]; then ldtc_cmd=version; fi
    if [ "$ldtc_cmd" = "version" ]; then ldtc_target=print; fi

    if [ ! "$ldtc_cmd" = "version" ] &&
        [ ! "$ldtc_cmd" = "usage" ] &&
        [ ! "$ldtc_cmd" = "compile" ]; then
        $logger logError "Unknown command!"
        $logger logDebug "-- cause: ldtc_cmd=$ldtc_cmd"
        exit 400
    fi

    ## validate:target
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

    ## validate:workingDirectory
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

    ## validate:in-out
    if [ "$ldtc_input" = "" ]; then
        ldtc_input=$ldtc_workindDir
    fi
    if [ "$ldtc_output" = "" ]; then
        ldtc_output=$ldtc_workindDir/dist
    fi
    if [ "$ldtc_fileName" = "" ]; then
        distFileName=$(basename $ldtc_workindDir)
        if [ -f "$ldtc_workindDir/VERSION" ]; then
            distFileVersion=$(cat $ldtc_workindDir/VERSION)
        else
            distFileVersion=latest
        fi
        ldtc_fileName="$distFileName-$distFileVersion.sh"
    fi
    if [ "$ldtc_chmod" = "" ] ||
        [ "$ldtc_chmod" = "-1" ]; then
        ldtc_chmod=000
    fi
}
