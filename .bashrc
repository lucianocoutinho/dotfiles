#!/bin/bash
#
# sample bash profile settings.
#

# set prompt
if [ $(id -u) = 0 ]; then
	PS1="\n(\e[31;1m\u\e[m - \w @\e[32;1m\t\e[m) \n\H: "
else
	PS1="\n(\e[34;1m\u\e[m - \w @\e[32;1m\t\e[m) \n\H: "
fi

# define aliases
alias ls='ls --color=tty '
alias cp='cp -i '
alias mv='mv -i '
alias rm='rm -i '
alias grep='grep --color=auto '
alias egrep='egrep --color=auto '
alias fgrep='fgrep --color=auto '

# set history control to avoid duplicated entries
export HISTCONTROL=erasedups
