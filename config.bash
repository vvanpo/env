
function config {
    local file=$PREFIX/src/$repo/default.config

    if [[ -f $PREFIX/etc/$name/config ]]; then
        file=$PREFIX/etc/$name/config
    fi

    case "$1" in
    '--add')
        if [[ ! -f $PREFIX/etc/$name/config ]]; then
            mkdir -p "$PREFIX/etc/$name"
            cp "$PREFIX/src/$repo/default.config" "$PREFIX/etc/$name/config"
        fi ;;
    esac

    git config -f "$file" "$@"
}

# Reads an input value if the requested config value isn't set.
function read-config {
    if [[ -z $(config --name-only -l | grep -E "^$1$") ]]; then
        local value
        printf '%s%s%s' "$2" "${3:+ [$3]}" ': '
        read value
        value="${value:-$3}"
        config --add "$1" "$value"
    fi
}
