
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

function install-etc {
    for file in "$@"; do
        install-file "$file" "$PREFIX/etc/$NAME/$file"
    done
}

function install-git {
    rm -f ~/.gitconfig
    git config --global --add user.name "$(config --get user.name)"
    git config --global --add user.email "$(config --get user.email)"
    install-etc gitignore
    git config --global --add core.excludesfile "$PREFIX/etc/$NAME/gitignore"
}

function install-bash {
    install-dot .bashrc .bash_profile .bash_logout
    install-etc inputrc

    # Our .bashrc can't load scripts without knowing the folder hierarchy.
    for var in NAME REPO PREFIX; do
        sed -i -E "s;^(${var,,}=)$;\1${!var};" ~/.bashrc
    done

    for file in $(config --get-all includes.bash.file); do
        install-file "$file" "$PREFIX/lib/$NAME/bash/"
    done
}

read-config 'user.name' 'Full name'
read-config 'user.email' 'E-mail'

install-dot .tmux.conf .vimrc
install-git
install-bash
