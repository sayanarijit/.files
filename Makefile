BREW = $(which brew || echo NOT_INSTALLED)
GIT = $(which git || echo NOT_INSTALLED)
PYTHON = $(which python || echo NOT_INSTALLED)
TMUX = $(which tmux || echo NOT_INSTALLED)
VIM = $(which vim || echo NOT_INSTALLED)
NVIM = $(which nvim || echo NOT_INSTALLED)
ZSH = $(which zsh || echo NOT_INSTALLED)
NOW = $(shell date)

.PHONY: all
all: brew zsh tmux git pyenv profile vim nvim

.PHONY: brew
brew: ${BREW}
${BREW}:
	@/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@brew tap caskroom/cask

.PHONY: zsh
zsh: ${ZSH} ~/.oh-my-zsh ~/.zshrc ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
${ZSH}: ${BREW}
	@brew install zsh
~/.oh-my-zsh: ${GIT}
	@git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
~/.zshrc: .zshrc
	@ln -sf "${PWD}/.zshrc" ~/.zshrc
	@chmod +x ~/.zshrc
~/.oh-my-zsh/custom/plugins/zsh-autosuggestions: ~/.oh-my-zsh
	@git clone https://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting: ~/.oh-my-zsh
# 	@git clone https://github.com/zsh-users/zsh-syntax-highlighting $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


.PHONY: tmux
tmux: ${TMUX} ~/.tmux.conf ~/.tmux/plugins/tpm
${TMUX}: ${BREW}
	@brew install tmux
	@tmux source ~/.tmux.conf
~/.tmux.conf: .tmux.conf
	@ln -sf "${PWD}/.tmux.conf" ~/.tmux.conf
~/.tmux/plugins/tpm: ${GIT}
	@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

.PHONY: git
git: ${GIT}
${GIT}: ${BREW}
	@brew install git
	@git config --global user.email "sayanarijit@gmail.com"
	@git config --global user.name "Arijit Basu"

.PHONY: pyenv
pyenv: ${PYTHON} ~/.profile ~/.pyenv/plugins
	brew install --HEAD pyenv-virtualenv
~/.pyenv: ${GIT}
	@git clone https://github.com/pyenv/pyenv.git ~/.pyenv
~/.pyenv/plugins: ${GIT} ~/.pyenv
	@git clone git://github.com/concordusapps/pyenv-implict.git ~/.pyenv/plugins/pyenv-implict

.PHONY: profile
profile: ~/.profile
~/.profile: .profile
	@ln -sf "${PWD}/.profile" ~/.profile
	@chmod +x ~/.profile

.PHONY: vim
vim: ${VIM} ~/.vim_runtime ~/.vimrc
${VIM}: ${BREW}
	@brew install vim
~/.vim_runtime: ${GIT}
	@git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
	@sh ~/.vim_runtime/install_awesome_vimrc.sh
	@git clone https://github.com/easymotion/vim-easymotion ~/.vim_runtime/my_plugins/vim-easymotion
~/.vimrc: .vimrc
	@ln -sf "${PWD}/.vimrc" ~/.vimrc

.PHONY: sync
sync:
	@git pull --rebase --autostash
	@git add . --all
	@git commit -m "${NOW}"
	@git push

.PHONY: nvim
nvim: ${NVIM} ~/.config/nvim
${NVIM}: ${BREW} ${GIT}
	@brew install neovim
	@git config --global core.editor nvim
	@curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
~/.config/nvim:
	@ln -sf "${PWD}/nvim" ~/.config/nvim

.PHONY: fonts
fonts: git
	@git clone https://github.com/powerline/fonts --depth=1 /tmp/fonts
	@cd /tmp/fonts && chmod +x install.sh && ./install.sh

.PHONY: utils
utils:
	@brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep

.PHONY: bash-completion
bash-completion: $(BREW)
	@brew install bash-completion
