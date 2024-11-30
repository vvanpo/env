# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html#variables
XDG_CONFIG_HOME=$PREFIX/etc
PATH=$HOME/.local/src/github.com/jenv/jenv/bin:$PREFIX/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
GOPATH=$PREFIX
MANPATH=$PREFIX/share/man:/usr/local/share/man:/usr/share/man
EDITOR=vim
VISUAL=vim
PAGER=less
LESS='-RSw'
LESSHISTFILE=-
INPUTRC=$PREFIX/src/$REPO/inputrc

export XDG_DATA_HOME XDG_CONFIG_HOME PATH GOPATH MANPATH EDITOR VISUAL PAGER LESS LESSHISTFILE INPUTRC
