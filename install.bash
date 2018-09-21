if [[ -z $PREFIX ]]; then
    2>&1 echo "Must provide a prefix path."
    exit 1
fi

git_version="$(git --version | cut -d' ' -f3)"

function install-link {
    if [[ -e $2 ]]; then
        (set -x; rm -f "$2")
    else
        mkdir -p "$(dirname "$2")"
    fi

    (set -x; ln -s "$prefix/src/$repo/$1" "$2")
}

function install-dot {
    for file in $@; do
        install-link $file ~/"$file"
    done
}

function install-git {
    local gitignore="$(dirname "$(config)")/gitignore"
    install-link .gitignore "$gitignore"
    rm -f ~/.gitconfig
    git config --global --add user.name "$(get-config user.name)"
    git config --global --add user.email "$(get-config user.email)"
    git config --global --add core.excludesfile "$gitignore"
}

function install-bash {
    install-dot .bashrc .bash_profile .bash_logout
    mkdir -p ~/.bash

    cd ~/.bash
    for url in "${includes[@]}"; do
        local file="$(basename "$url")"
        [[ -e $file ]] && (set -x; rm -f "$file")
        (set -x; curl -fsSLO "$url")
    done
    >/dev/null cd -
}

. "$(dirname "$0")/init" -s
install-link 'init' "$prefix/bin/update-$name"

read-config 'user.name' 'Full name'
read-config 'user.email' 'E-mail'

install-dot .tmux.conf .vimrc
install-git
install-bash
