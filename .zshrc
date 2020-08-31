###
### local custom settings
###

## # Set up the prompt
## autoload -Uz promptinit
## promptinit

if [ $(id -u) = 0 ] ; then
  PS1=$'\n(\e[1;31m%n [!]\e[m - %d \e[1;32m @%*\e[m) \n%M%% '
else
  PS1=$'\n(\e[1;34m%n\e[m - %d \e[1;32m @%*\e[m) \n%M%% '
fi

## Set prompt to show git and kubernetes information.
## # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kube-ps1
## KUBE_PS1_PREFIX=''
## KUBE_PS1_SUFFIX=''
## KUBE_PS1_SYMBOL_ENABLE=false
## PS1=$'\n%{$fg[white]%}[%n@%m]%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%} %{$fg[white]%}@%*%{$reset_color%} $(kube_ps1)\n$(git_prompt_info)$(bzr_prompt_info)[%?]%{$fg_bold[black]%}%#%{$reset_color%} '

setopt AUTO_PUSHD
setopt AUTO_LIST
setopt NO_PROMPT_CR
setopt NO_BEEP
setopt AUTO_MENU
setopt COMPLETE_ALIASES
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

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=500000
export SAVEHIST=300000

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*:*:*' hosts $ssh_config_hosts $ssh_known_hosts
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' hosts $hosts
zstyle ':completion:*' list-colors "$LS_COLORS"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' ''
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' menu select=1
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

if [ -d /usr/local/share/zsh-completions ] ; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# FIXME: not sure yet if is a good choice...
bindkey -v   # vi key bindings
bindkey ' ' magic-space  # also do history expansion on space
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^r' history-incremental-search-backward
bindkey '^y' yank
bindkey '^t' delete-word
bindkey '^x' copy-prev-shell-word
bindkey '^z' vi-undo-change
bindkey '^w' forward-word
bindkey '^b' backward-word

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# define aliases
if [ "$(uname -s)" = "Darwin" ] ; then
  alias ls='ls -a -G '

elif [ "$(uname -s)" = "Linux" ] ; then
  alias ls='ls -a --color=tty '

else
  alias ls='ls -a '
fi
alias cp='cp -i '
alias mv='mv -i '
alias rm='rm -i '
alias grep='grep --color=auto '
alias egrep='egrep --color=auto '
alias fgrep='fgrep --color=auto '
alias ssh='ssh -YC '
alias gvim='gvim -O '
# kept for reference only and to get used to use fc instead of history
#alias history='fc -li 0'

alias ts="date '+%FT%T.%N%z'"
alias find='noglob find'

alias youtube-dl-best="youtube-dl -c -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"

# manage network sharing
alias enable_network_share="echo 'nat on en0 from en5:network to any -> (en0)' > /tmp/pf.conf.tmp && \
	sudo sysctl -w net.inet.ip.forwarding=1 && \
	sudo pfctl -d -q 2>/dev/null ; sudo pfctl -q -e -f /tmp/pf.conf.tmp 2> /dev/null && \
	rm -f /tmp/pf.conf.tmp"

alias disable_network_share="sudo pfctl -d -q 2>/dev/null && sudo sysctl -w net.inet.ip.forwarding=0"

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
type fortune > /dev/null 2>&1
[ $? -eq 0 ] && (echo && fortune -s computers)

# run local settings if exists
if [[ -f ~/.zshrc.local ]]; then
  . ~/.zshrc.local
fi

### # macOS only: resize terminal window in case we are using a big screen
### if [ "$(uname -s)" = "Darwin" -a -n "${TERM_PROGRAM}" \
###        -a "${TERM_PROGRAM}" = "Apple_Terminal" ] ; then
### 
###   # get screen resolution
###   resolution="$(system_profiler SPDisplaysDataType | grep Resolution \
###                  | awk '{print $2}' | head -1)"
### 
###   # resize and position the window based in the resolution
###   if [ "${resolution}" = "1920" ] ; then
###     # resize window to 220x62
###     printf '\e[8;62;220t'
### 
###     # put the window in the middle of screen
###     osascript \
###       -e 'tell application "Terminal"' \
###       -e 'set position of front window to {250, 100}' \
###       -e 'end tell'
### 
###   else
###     # resize window to 135
###     printf '\e[8;40;135'
### 
###     # put the window in the middle of screen
###     osascript \
###       -e 'tell application "Terminal"' \
###       -e 'set position of front window to {200, 50}' \
###       -e 'end tell'
### 
###   fi
### 
### fi

# EOF
