export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export PATH="$PATH:$HOME/eclipse/jee-2018-12/Eclipse.app/Contents/MacOS:$HOME/Library/Python/3.6/bin:/usr/local/go/bin:$HOME/go/bin:$HOME/.npm-global/bin"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LANG=C
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# For compilers to find readline you may need to set:
# export LDFLAGS="-L/usr/local/opt/sqlite/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/readline/lib"
# export CPPFLAGS="-I/usr/local/opt/readline/include -I/usr/local/opt/sqlite/include -I/usr/local/opt/zlib/include"

# For pkg-config to find readline you may need to set:
# export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"

alias ubuntu="VBoxManage startvm --type headless ubuntu && sleep 15 && ssh ubuntu"
alias venv="virtualenv venv && activate"
alias activate="source venv/bin/activate"
alias reactivate="deactivate && activate"
alias ebn="cd ~/Documents/GitHub/ebn && tmux new pipenv shell"
alias minisites="cd ~/Documents/GitHub/minisites && tmux new pipenv shell"

# export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[[ -r "/usr/local/etc/profile.d/bash_completion.sh"  ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
