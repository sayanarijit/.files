SHELL := /bin/bash

.PHONY: all
all:
	curl -L https://nixos.org/nix/install -o install.sh \
		&& sh install.sh --darwin-use-unencrypted-nix-store-volume \
		&& rm -f install.sh
	. ~/.nix-profile/etc/profile.d/nix.sh
	cp .nix-channels ~/
	export PATH=$$HOME/.nix-profile/bin/:$$PATH
	nix-channel --update
	nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
	./result/bin/darwin-installer
	rm -rf ./result
	darwin-rebuild switch
	nix-shell '<home-manager>' -A install
	which dotsync

.PHONY: sync
sync:
	@git pull --rebase --autostash
	@git add . --all
	@git commit -m "$(shell date)"
	@git push
