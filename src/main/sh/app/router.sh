run() {
    if [ "$ldtc_cmd" = "version" ]; then
        if [ "$ldtc_target" = "print" ]; then
            doPrintVersion
        fi
    fi
    if [ "$ldtc_cmd" = "usage" ]; then
        if [ "$ldtc_target" = "print" ]; then
            doPrintUsage
        fi
    fi
    if [ "$ldtc_cmd" = "compile" ]; then
        if [ "$ldtc_target" = "bash-app" ]; then
            doCompileBashApplication
        fi
        if [ "$ldtc_target" = "bash-application" ]; then
            doCompileBashApplication
        fi
        if [ "$ldtc_target" = "compose" ]; then
            doCompileDockerCompose
        fi
        if [ "$ldtc_target" = "docker-compose" ]; then
            doCompileDockerCompose
        fi
        if [ "$ldtc_target" = "nginx" ]; then
            doCompileNginxConf
        fi
        if [ "$ldtc_target" = "nginx-config" ]; then
            doCompileNginxConf
        fi
    fi
}
