doCompileBashApplication() {
    $logger logDebug "compile... 'BashApplication'"
    $logger logDebug "-- ldtc_me=$ldtc_me"
    $logger logDebug "-- ldtc_cmd=$ldtc_cmd"
    $logger logDebug "-- ldtc_target=$ldtc_target"
    $logger logDebug "-- ldtc_workindDir=$ldtc_workindDir"
    $logger logDebug "-- -- ldtc_input=$ldtc_input"
    $logger logDebug "-- -- ldtc_output=$ldtc_output"
    $logger logDebug "-- -- ldtc_fileName=$ldtc_fileName"
    $logger logDebug "-- -- ldtc_chmod=$ldtc_chmod"

    if [ -d $ldtc_output ]; then rm -rf $ldtc_output; fi
    if [ ! -d $ldtc_output ]; then
        mkdir -p $ldtc_output
        touch $ldtc_output/$ldtc_fileName
    fi

    if [ -f $ldtc_input/src/main/resources/USAGE.txt ]; then
        echo "doPrintUsage() {" > \
            $ldtc_input/src/main/sh/tasks/doPrintUsage.sh
        echo "echo \"=============================================" >> \
            $ldtc_input/src/main/sh/tasks/doPrintUsage.sh
        cat $ldtc_input/src/main/resources/USAGE.txt >> \
            $ldtc_input/src/main/sh/tasks/doPrintUsage.sh
        echo "\"" >> \
            $ldtc_input/src/main/sh/tasks/doPrintUsage.sh
        echo "}" >> \
            $ldtc_input/src/main/sh/tasks/doPrintUsage.sh
    fi

    cat $ldtc_input/src/main/sh/app/main.sh > \
        $ldtc_output/$ldtc_fileName
    cat $ldtc_input/src/main/sh/app/parser.sh >> \
        $ldtc_output/$ldtc_fileName
    cat $ldtc_input/src/main/sh/app/loader.sh >> \
        $ldtc_output/$ldtc_fileName
    cat $ldtc_input/src/main/sh/app/validator.sh >> \
        $ldtc_output/$ldtc_fileName
    cat $ldtc_input/src/main/sh/app/router.sh >> \
        $ldtc_output/$ldtc_fileName
    find $ldtc_input/src/main/sh/tasks/ -name '*.sh' -exec cat "{}" \; >> \
        $ldtc_output/$ldtc_fileName
    cat $ldtc_input/src/main/sh/app/runner.sh >> \
        $ldtc_output/$ldtc_fileName

    chmod $ldtc_chmod $ldtc_output/$ldtc_fileName

    $logger logDebug "compiled."
}
