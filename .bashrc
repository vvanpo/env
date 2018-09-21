# Non-interactive remote shells may still source .bashrc, so we test for an
# interactive shell and exit otherwise.
[[ -z $PS1 ]] && return

name=
repo=
prefix=

set -o vi




## Source files from includes directory.
for script in "$prefix/lib/$name/bash/"*; do
    . "$script"
done
