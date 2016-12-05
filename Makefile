all:
	@echo possible targets bash ssh screen tmux vim zsh psql irb install and install-all

install: bash ssh screen tmux vim zsh
install-all: bash ssh screen tmux vim zsh psql irb

ssh:
	install -d -m 0755 ${HOME}/.ssh
	install -b -m 0644 ssh_config ${HOME}/.ssh/config
	install -b -m 0644 ssh_authorized_keys ${HOME}/.ssh/authorized_keys

tmux:
	install -b -m 0644 .tmux.conf ${HOME}/.tmux.conf

screen:
	install -b -m 0644 .screenrc ${HOME}/.screenrc

bash:
	install -b -m 0644 .bashrc ${HOME}/.bashrc

vim:
	install -b -m 0644 .vimrc ${HOME}/.vimrc

zsh:
	install -b -m 0644 .zshrc ${HOME}/.zshrc
	rm ${HOME}/.zcompdump* 2> /dev/null || exit 0
	zsh -c 'zcompile ${HOME}/.zshrc' 2> /dev/null || exit 0
	if [ -f ${HOME}/.zshrc.local ] ; then zsh -c 'zcompile ${HOME}/.zshrc.local' 2> /dev/null || exit 0 ; fi

psql:
	install -b -m 0644 .psqlrc ${HOME}/.psqlrc

irb:
	install -b -m 0644 .irbrc ${HOME}/.irbrc

