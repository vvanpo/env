# Non-interactive remote shells may still source .bashrc, so we test for an
# interactive shell and exit otherwise.
[[ -z $PS1 ]] && return

## Shell configuration and variables
set -o vi
path=~/.local
export EDITOR=vim VISUAL=vim
export PAGER='less -RSW'
export LESSHISTFILE=-
export XDG_DATA_HOME=$path/share
export XDG_CONFIG_HOME=$path/etc
export GOPATH=$path
export PATH=$path/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export MANPATH=$path/share/man:/usr/local/share/man:/usr/share/man

## Aliases
alias ls='ls --color=always' l='ls -lah' ll='l | r'
alias r='less -RSW'
alias grep='grep -E --color=always'
alias gits='git status' gitl='git log --oneline -n15'
alias ps='ps -efjH | r'

## Command prompt

# Resets attributes.
RST="\[\e[m\]"
BOLD="\[\e[1m\]"
# Default text colour.
DFLT="\[\e[39m\]"
RED="\[\e[31m\]"
GRN="\[\e[32m\]"
YEL="\[\e[33m\]"
BLUE="\[\e[34m\]"

if [[ $SSH_CLIENT ]]; then
    PS1_PREFIX="ssh://$BOLD$GRN\u$DFLT@$RED\H$RST:"
else
    PS1_PREFIX="$BOLD$GRN\u$RST:"
fi

PS1_POSTFIX=" $BOLD$BLUE\w\n\$$RST "
PS1=$PS1_PREFIX'$(__git_ps1)'$PS1_POSTFIX
# Displays a '*' or '+' for unstaged or staged changes.
export GIT_PS1_SHOWDIRTYSTATE=true
# Displays a '$' for stashed files.
export GIT_PS1_SHOWSTASHSTATE=true
# Displays a '%' for untracked files.
export GIT_PS1_SHOWUNTRACKEDFILES=true
# Sets the prompt for `sudo su`.
export SUDO_PS1=$PS1_PREFIX$PS1_POSTFIX
# Secondary prompt for multi-line commands.
PS2="  $BLUE>$RST "
# Trims the path to 3 components in the PS1, replacing it with an ellipsis.
PROMPT_DIRTRIM=3

## Source files from includes directory.
for script in ~/.bash/*; do
    . $script
done
