###
### local custom settings
###
if [ $(id -u) = 0 ] ; then
  PS1=$'\n(\e[1;31m%n [!]\e[m - %d \e[1;32m @%*\e[m) \n%M%% '
else
  PS1=$'\n(\e[1;34m%n\e[m - %d \e[1;32m @%*\e[m) \n%M%% '
fi

setopt NO_PROMPT_CR
setopt NO_BEEP
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB
setopt AUTOCD
setopt INTERACTIVE_COMMENTS
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

export HISTFILE=$HOME/~.zsh_history
export HISTSIZE=500000
export SAVEHIST=300000

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' menu select=1
zstyle ':completion:*' verbose true

autoload -U compinit
compinit -d ~/.zcompdump.`hostname`

# FIXME: not sure yet if is a good choice...
# bindkey -v   # vi key bindings
bindkey ' ' magic-space  # also do history expansion on space
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^r' history-incremental-search-backward
bindkey '^y' yank
bindkey '^t' delete-word
bindkey '^x' copy-prev-shell-word
bindkey '^z' vi-undo-change

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# define aliases
alias cvim="vim -c 'set autoindent' -c 'set number'"
alias cim="vim -c 'set autoindent' -c 'set number'"
if [ "$(uname -s)" = "Darwin" ] ; then
  alias ls='ls -a -G '
  alias history='fc -fdl'
else
  alias ls='ls -a --color=tty '
fi
alias cp='cp -i '
alias mv='mv -i '
alias rm='rm -i '
alias grep='grep --color=always '
alias egrep='egrep --color=always '
alias fgrep='fgrep --color=always '
alias ssh='ssh -YC '
alias gvim='gvim -p '

# fix path
for dir in /usr/local/bin /usr/local/sbin \
  /opt/local/bin /opt/local/sbin $HOME/System/bin \
  $HOME/bin $HOME/sbin ; do
    if [ -d ${dir} ] ; then
      export PATH="$PATH:${dir}"
    fi
done

# rbenv settings
if [[ -d $HOME/.rbenv ]] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# just for fun... :-)
type fortune 2>&1 > /dev/null
[ $? -eq 0 ] && (echo && fortune -s computers)

# run local settings if exists
if [[ -f ~/.zshrc.local ]]; then
  . ~/.zshrc.local
fi

# EOF
