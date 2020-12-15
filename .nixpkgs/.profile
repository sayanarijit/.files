export PATH="$PATH:/usr/local/bin:$HOME/eclipse/jee-2018-12/Eclipse.app/Contents/MacOS:$HOME/Library/Python/3.6/bin:/usr/local/go/bin:$HOME/go/bin:$HOME/.npm-global/bin:/Applications/Firefox Developer Edition.app/Contents/MacOS"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:$HOME/.bin"
export PATH="/run/current-system/sw/bin:$PATH"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LANG=en_US
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export NIX_PATH="darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels"

# For compilers to find readline you may need to set:
export LDFLAGS="-L/usr/local/opt/sqlite/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include -I/usr/local/opt/sqlite/include -I/usr/local/opt/zlib/include"

# For pkg-config to find readline you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"

alias dotsync="(cd ~/.files && make sync)"

alias ~="cd"
alias ..="cd .."
alias venv="virtualenv .venv && activate"
alias activate="source .venv/bin/activate"
alias reactivate="deactivate && activate"
alias github="cd ~/Documents/GitHub"
alias ebn="cd ~/Documents/GitHub/ebn"
alias minisites="cd ~/Documents/GitHub/minisites"
alias kai="cd ~/Documents/GitHub/kai-app"
alias kaib="cd ~/Documents/GitHub/kai-app/backend"
alias kaif="cd ~/Documents/GitHub/kai-app/frontend"

# alias vim="nvim"

alias nixd="launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist && launchctl start org.nixos.nix-daemon"

# Getting rusty
alias cat="bat"
alias ls="lsd"
alias m="mind"

# export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export MANPAGER='nvim +Man!'
# eval $(thefuck --alias)
eval "$(pyenv init -)"
source $HOME/.poetry/env


function paste() {
    local file=${1:-/dev/stdin}
    curl --data-binary @${file} https://paste.rs
}

[[ -r /usr/local/etc/profile.d/bash_completion.sh  ]] && . /usr/local/etc/profile.d/bash_completion.sh
[[ -r "$HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br" ]] && . "$HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br"
[[ -r "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"
