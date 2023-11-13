parse() {
    args=()

    for arg in "$@"; do
        case "$arg" in
        --debug)
            LDT_COMPILER_DEBUG_MODE=true
            ;;
        -t | --target)
            LDT_COMPILER_TARGET_FLAG=true
            ;;
        *)
            if [ "$LDT_COMPILER_TARGET_FLAG" = "true" ]; then
                LDT_COMPILER_TARGET_FLAG=false
                LDT_COMPILER_TARGET=$arg
                continue
            fi
            args+=($arg)
            ;;
        esac
    done
}
