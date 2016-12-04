###
### local custom settings
###
# set prompt
if [ $(id -u) = 0 ]; then
  PS1="\n(\e[31;1m\u\e[m - \w @\e[32;1m\t\e[m) \n\H: "
else
  PS1="\n(\e[34;1m\u\e[m - \w @\e[32;1m\t\e[m) \n\H: "
fi

# set history control to avoid duplicated entries
export HISTCONTROL=erasedups

# define aliases
if [ "$(uname -s)" = "Darwin" ] ; then
  alias ls='ls -a -G '
else
  alias ls='ls -a --color=tty '
fi
alias cp='cp -i '
alias mv='mv -i '
alias rm='rm -i '
alias grep='grep --color=auto '
alias egrep='egrep --color=auto '
alias fgrep='fgrep --color=auto '
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

# just for fun ... :-)
type fortune 2>&1 > /dev/null
[ $? -eq 0 ] && (echo && fortune -s computers)

# FIXME: enable bash completion in macOS
type brew  2>&1 > /dev/null
if [ $? -eq 0 ] ; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi
fi

# vim:ts=4:sw=4
