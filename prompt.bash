reset=$'\[\e[m\]'
bold=$'\[\e[1m\]'
red=$'\[\e[31m\]'
green=$'\[\e[32m\]'
yellow=$'\[\e[33m\]'
blue=$'\[\e[34m\]'
default=$'\[\e[39m\]'

prefix="${yellow}\D{%H:%M} ${bold}${green}\u${reset}:"
[[ $SSH_CLIENT ]] && prefix="ssh://${bold}${green}\u${default}@${red}\H${reset}:"
postfix=" ${bold}${blue}\w\n\$${reset} "

# Running git from a Windows mount in WSL2 is slow, causing each prompt to hang for a second.
function _git_ps1_proxy {
	if [[ $WSL_DISTRO_NAME && $(pwd -P) != /mnt/* ]]; then
		__git_ps1
	else
		echo -n " (windows /mnt)"
	fi
}

PS1="${prefix}\$(_git_ps1_proxy)${postfix}"
# Secondary prompt for multi-line commands.
PS2="  ${blue}>${reset} "
# Trims the path to 3 components in the PS1, replacing it with an ellipsis.
PROMPT_DIRTRIM=3

# Sets the prompt for `sudo su`.
export SUDO_PS1=${prefix}${postfix}

# Displays a '*' or '+' for unstaged or staged changes.
GIT_PS1_SHOWDIRTYSTATE=true
# Displays a '$' for stashed files.
GIT_PS1_SHOWSTASHSTATE=true
# Displays a '%' for untracked files.
GIT_PS1_SHOWUNTRACKEDFILES=true

unset prefix postfix reset bold red green yellow blue default
