export PATH="/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/postgresql@9.6/bin:/usr/local/sbin:/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/eclipse/jee-2018-12/Eclipse.app/Contents/MacOS:$HOME/Library/Python/3.6/bin:/usr/local/go/bin:$HOME/go/bin:$HOME/.npm-global/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LANG=en_US
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim

# For compilers to find readline you may need to set:
export LDFLAGS="-L/usr/local/opt/sqlite/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include -I/usr/local/opt/sqlite/include -I/usr/local/opt/zlib/include"

# For pkg-config to find readline you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"

alias dotsync="cd ~/.files && make sync && 1"

alias ubuntu="VBoxManage startvm --type headless ubuntu && sleep 15 && ssh ubuntu"
alias venv="virtualenv .venv && activate"
alias activate="source .venv/bin/activate"
alias reactivate="deactivate && activate"
alias github="cd ~/Documents/GitHub"
alias ebn="cd ~/Documents/GitHub/ebn"
alias minisites="cd ~/Documents/GitHub/minisites"

alias ctags="`brew --prefix`/bin/ctags"
alias emacs="`brew --prefix`/bin/emacs"

# export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[[ -r "/usr/local/etc/profile.d/bash_completion.sh"  ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
