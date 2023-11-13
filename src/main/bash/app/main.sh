main() {
    ldt_compiler_loadContext
    ldt_compiler_parseArgs $*
    ldt_compiler_validateArgs
    ldt_compiler_routeTask
    return $ldt_compiler_exitCode
}
