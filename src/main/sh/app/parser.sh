parse() {
    args=()

    for arg in "$@"; do
        case "$arg" in
        --chmod)
            LDT_COMPILER_CHMOD_FLAG=true
            ;;
        --debug)
            LDT_COMPILER_DEBUG_MODE=true
            ;;
        -f | --fileName)
            LDT_COMPILER_FILE_NAME_FLAG=true
            ;;
        -i | --input)
            LDT_COMPILER_INPUT_FLAG=true
            ;;
        -o | --output)
            LDT_COMPILER_OUTPUT_FLAG=true
            ;;
        -t | --target)
            LDT_COMPILER_TARGET_FLAG=true
            ;;
        *)
            if [ "$LDT_COMPILER_CHMOD_FLAG" = "true" ]; then
                LDT_COMPILER_CHMOD_FLAG=false
                LDT_COMPILER_CHMOD=$arg
                continue
            fi
            if [ "$LDT_COMPILER_FILE_NAME_FLAG" = "true" ]; then
                LDT_COMPILER_FILE_NAME_FLAG=false
                LDT_COMPILER_FILE_NAME=$arg
                continue
            fi
            if [ "$LDT_COMPILER_INPUT_FLAG" = "true" ]; then
                LDT_COMPILER_INPUT_FLAG=false
                LDT_COMPILER_INPUT=$arg
                continue
            fi
            if [ "$LDT_COMPILER_OUTPUT_FLAG" = "true" ]; then
                LDT_COMPILER_OUTPUT_FLAG=false
                LDT_COMPILER_OUTPUT=$arg
                continue
            fi
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
