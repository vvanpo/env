git_version="$(git --version | cut -d' ' -f3)"

function install-file {
    if [[ -e $2 ]] && [[ ! -d $2 ]]; then
        rm -f "$2"
    elif [[ ${2%%/} != $2 ]]; then
        mkdir -p "$2"
    else
        mkdir -p "$(dirname "$2")"
    fi

    (set -x; cp "$PREFIX/src/$repo/$1" "$2")
}

# Installs dot-files that live in ~/.
function install-dot {
    for file in "$@"; do
        install-file "$file" ~/"$file"
    done
}

function install-git {
    local gitignore="$PREFIX/etc/$name/gitignore"
    install-file .gitignore "$gitignore"
    rm -f ~/.gitconfig
    git config --global --add user.name "$(get-config user.name)"
    git config --global --add user.email "$(get-config user.email)"
    git config --global --add core.excludesfile "$gitignore"
}

function install-bash {
    install-dot .bashrc .bash_profile .bash_logout
    mkdir -p ~/.bash
    files=$(git config -f "$(config-file)" --get-all includes.bash.file)

    for file in $files; do
        install-file "$file" ~/.bash/
    done
}

install-file 'init' "$PREFIX/bin/update-$name"

read-config 'user.name' 'Full name'
read-config 'user.email' 'E-mail'

install-dot .tmux.conf .vimrc
install-git
install-bash
