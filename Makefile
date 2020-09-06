SHELL := /bin/bash

.PHONY: all
all:
	curl -L https://nixos.org/nix/install -o install.sh \
		&& sh install.sh --darwin-use-unencrypted-nix-store-volume \
		&& rm -f install.sh
	. ~/.nix-profile/etc/profile.d/nix.sh
	for f in $(ls -d .*); do [ -f $f ] && ln -sf $f ~/; done
	ln -sf .bin ~/
	ln -sf .nixpkgs ~/
	[ ! -d ~/.config ] && mkdir ~/.config || true
	for d in $(ls -d .config/*); do [ -d .config/$d ] && ln -sf .config/$d ~/.config/; done
	source ~/.profile
	nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
	./result/bin/darwin-installer
	rm -rf ./result
	source ~/.profile
	darwin-rebuild switch

.PHONY: sync
sync:
	@git pull --rebase --autostash
	@git add . --all
	@git commit -m "$(shell date)"
	@git push
