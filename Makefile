SHELL := /bin/bash

.PHONY: all
all:
	sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
	. ~/.nix-profile/etc/profile.d/nix.sh
	cp .nix-channels ~/
	export PATH=$$HOME/.nix-profile/bin/:$$PATH
	export NIX_PATH=darwin-config=$$HOME/.nixpkgs/darwin-configuration.nix:$$HOME/.nix-defexpr/channels
	nix-channel --add https://nixos.org/channels/nixpkgs-unstable
	nix-channel --update
	nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
	./result/bin/darwin-installer
	rm -rf ./result
	darwin-rebuild switch
	source /etc/static/bashrc
	nix-shell '<home-manager>' -A install
	which dotsync

.PHONY: sync
sync:
	@git pull --rebase --autostash
	@git add . --all
	@git commit -m "$(shell date)"
	@git push
