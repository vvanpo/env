
function config-file {
    if [[ -f $PREFIX/etc/$name/config ]]; then
        echo "$PREFIX/etc/$name/config"
    else
        echo "$PREFIX/src/$repo/default.config"
    fi
}

function get-config {
    git config -f "$(config-file)" --get "$1"
}

function set-config {
    if [[ -f $PREFIX/etc/$name/config ]]; then
        mkdir -p "$PREFIX/etc/$name"
        cp "$PREFIX/src/$repo/default.config" "$PREFIX/etc/$name/config"
    fi

    git config -f "$(config-file)" --add "$1" "$2"
}

# Reads an input value if the requested config value isn't set.
function read-config {
    if [[ -z $(git config -f "$(config-file)" --name-only -l | grep -E "^$1$") ]]; then
        local value
        printf '%s%s%s' "$2" "${3:+ [$3]}" ': '
        read value
        value="${value:-$3}"
        set-config "$1" "$value"
    fi
}
