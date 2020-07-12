# export PATH="/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/postgresql@9.6/bin:/usr/local/sbin:/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/eclipse/jee-2018-12/Eclipse.app/Contents/MacOS:$HOME/Library/Python/3.6/bin:/usr/local/go/bin:$HOME/go/bin:$HOME/.npm-global/bin:/Applications/Firefox Developer Edition.app/Contents/MacOS"
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# export PATH="$PATH:$HOME/.bin"
# export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH="/run/current-system/sw/bin:$PATH"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LANG=en_US
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export NIX_PATH="darwin-config=/Users/sayan/.nixpkgs/darwin-configuration.nix:/nix/var/nix/profiles/per-user/root/channels:/Users/sayan/.nix-defexpr/channels"

# For compilers to find readline you may need to set:
export LDFLAGS="-L/usr/local/opt/sqlite/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include -I/usr/local/opt/sqlite/include -I/usr/local/opt/zlib/include"

# For pkg-config to find readline you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"

alias dotsync="(cd ~/.files && make sync)"

alias venv="virtualenv .venv && activate"
alias activate="source .venv/bin/activate"
alias reactivate="deactivate && activate"
alias github="cd ~/Documents/GitHub"
alias ebn="cd ~/Documents/GitHub/ebn"
alias minisites="cd ~/Documents/GitHub/minisites"

alias ctags="`brew --prefix`/bin/ctags"
alias vim="nvim"

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
eval $(thefuck --alias)
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
source $HOME/.poetry/env

[[ -r /usr/local/etc/profile.d/bash_completion.sh  ]] && . /usr/local/etc/profile.d/bash_completion.sh
[[ -r "$HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br" ]] && . "$HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br"
[[ -r "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"
