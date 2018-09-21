prefix="${bold}${green}\u${reset}:"
[[ $SSH_CLIENT ]] && prefix="ssh://${bold}${green}\u${default}@${red}\H${reset}:"
postfix=" ${bold}${blue}\w\n\$${reset} "

PS1=$prefix'$(__git_ps1)'$postfix
# Secondary prompt for multi-line commands.
PS2="  $blue>$reset "
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
