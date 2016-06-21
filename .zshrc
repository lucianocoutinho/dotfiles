# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

## I guess this autoload is making shell init soooo long.
## Thu Sep 06 2012 Luciano Coutinho <lucianocoutinho@live.com>
## autoload -U compinit
## compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE

## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY

## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY
# avoid duplicated history
setopt HIST_FIND_NO_DUPS
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=500000
export SAVEHIST=300000


## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

# autoload -U colors
#colors

# Emacs
bindkey -e

# Opcoes
setopt autocd nobeep auto_list complete_in_word \
	auto_pushd complete_aliases extended_glob zle

setopt append_history extended_history inc_append_history \
	hist_save_no_dups hist_ignore_dups


zstyle ':completion:*:*:*' hosts $ssh_config_hosts $ssh_known_hosts
zstyle ':completion:*' hosts $hosts
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' list-colors "$LS_COLORS"
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit


#PATH=/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/System/bin:$HOME/sys/bin:/sbin:/usr/sbin:$PATH

run-in-gdb() {
   # This function is ZLE widget that runs the current command in gdb.
   # Since gdb doesn't take the program's arguments as arguments to gdb
   # itself but rather through the interpreter, a "run" command is
   # printed
   # out to a temporary file which is invoked as script for gdb to grab
   # commands from at startup.

   # Commit current command line to history, inset its words in a gdb
   # command, expand history to bypass HIST_VERIFY, and run it.
   print -s ${(z)BUFFER}
   BUFFER="gdb !!0 -x =(echo run !!1*)"
   zle expand-history
   zle accept-line
}
zle -N run-in-gdb
bindkey "^X^G" run-in-gdb

# emula o comando "md5sum" do Linux
function md5sum() {
    md5 $* | awk -F ' ' '{print $4 "  " $2}' | sed 's/[()]//g'
}

#PS1=$'\n(\e[1;34m%n \e[m - %d \e[1;32m @%*\e[m) \n%M: '
#PS1=$'\n\e[1;34m%n@%m\e[m:%d \e[1;32m@%*\e[m \n%% '
#PS1=$'\n\e[1;34m@%m\e[m:%d \e[1;32m@%*\e[m \n%% '

# change the prompt if using docker
if [ -z $DOCKER_HOST ] ; then
	PS1=$'\n\e[1;34m@%m\e[m:%d \e[1;32m@%*\e[m \n%% '
else
	PS1=$'\n\e[1;34m@%m\e[m:%d \e[1;32m@%*\e[m \e[1;31m[docker]\e[m \n%% '
fi

export CVS_RSH=ssh
export EDITOR="vim"
export SVNEDITOR="vim"
export SVN_EDITOR="$SVNEDITOR"
export CVSEDITOR="$SVNEDITOR"
export CVS_EDITOR="$SVNEDITOR"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# funny
type fortune 2>&1 > /dev/null
[ $? -eq 0 ] && (echo && fortune -s computers)

## my local aliases
alias history='fc -fdl'
alias df='df -hl'
alias ls='ls -G'
alias dmesg='sudo dmesg'
alias vi='vim'
alias rm='rm -i'
alias cp='cp -i'
alias grep='sudo grep --color=auto'
alias egrep='sudo egrep --color=auto'
alias fgrep='sudo fgrep --color=auto'
alias ssh='ssh -YC'
alias svnpropset='svn propset svn:keywords "Id Author Header Revision Date" '

# open multiple files in gvim in tabs
alias gvim='gvim -p'

# start/stop mysql
alias start_mysql='mysqld_safe &'
alias stop_mysql='kill -15 $(< /usr/local/var/mysql/mysqld.pid)'

# rbenv init
eval "$(rbenv init -)"

# EOF
