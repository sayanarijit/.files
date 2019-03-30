BREW = $(which brew || echo NOT_INSTALLED)
GIT = $(which git || echo NOT_INSTALLED)
PYTHON = $(which python || echo NOT_INSTALLED)
TMUX = $(which tmux || echo NOT_INSTALLED)
VIM = $(which vim || echo NOT_INSTALLED)
ZSH = $(which zsh || echo NOT_INSTALLED)
NOW = $(date)

.PHONY: all
all: brew zsh tmux git pyenv profile vim

.PHONY: brew
brew: ${BREW}
${BREW}:
	@/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@brew tap caskroom/cask

.PHONY: zsh
zsh: ${ZSH} ~/.oh-my-zsh ~/.zshrc
${ZSH}: ${BREW}
	@brew install zsh
~/.oh-my-zsh: ${GIT}
	@git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
~/.zshrc: .zshrc
	@ln -sf "${PWD}/.zshrc" ~/.zshrc

.PHONY: tmux
tmux: ${TMUX} ~/.tmux.conf
${TMUX}: ${BREW}
	@brew install tmux
~/.tmux.conf: .tmux.conf
	@ln -sf "${PWD}/.tmux.conf" ~/.tmux.conf

.PHONY: git
git: ${GIT}
${GIT}: ${BREW}
	@brew install git

.PHONY: pyenv
pyenv: ${PYTHON} ~/.profile ~/.pyenv
~/.pyenv: ${GIT}
	@git clone https://github.com/pyenv/pyenv.git ~/.pyenv

.PHONY: profile
profile: ~/.profile
~/.profile: .profile
	@ln -sf "${PWD}/.profile" ~/.profile

.PHONY: vim
vim: ${VIM} ~/.vim_runtime ~/.vimrc
${VIM}: ${BREW}
	@brew install vim
~/.vim_runtime: ${GIT}
	@git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
	@sh ~/.vim_runtime/install_awesome_vimrc.sh
~/.vimrc: .vimrc
	@ln -sf "${PWD}/.vimrc" ~/.vimrc

.PHONY: sync
sync:
	@git add . --all
	@git commit -m "{now}"
	@git push
