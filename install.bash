
function install-file {
    if [[ -e $2 ]] && [[ ! -d $2 ]]; then
        rm -f "$2"
    elif [[ ${2%%/} != $2 ]]; then
        mkdir -p "$2"
    else
        mkdir -p "$(dirname "$2")"
    fi

    (set -x; cp "$PREFIX/src/$REPO/$1" "$2")
}

# Installs dot-files that live in ~/.
function install-dot {
    for file in "$@"; do
        install-file "$file" ~/"$file"
    done
}

function install-git {
    local gitignore="$PREFIX/etc/$NAME/gitignore"
    install-file .gitignore "$gitignore"
    rm -f ~/.gitconfig
    git config --global --add user.name "$(config --get user.name)"
    git config --global --add user.email "$(config --get user.email)"
    git config --global --add core.excludesfile "$gitignore"
}

function install-bash {
    install-dot .bashrc .bash_profile .bash_logout

    for file in $(config --get-all includes.bash.file); do
        install-file "$file" "$PREFIX/lib/$NAME/bash/"
    done
}

read-config 'user.name' 'Full name'
read-config 'user.email' 'E-mail'

install-dot .tmux.conf .vimrc
install-git
install-bash
