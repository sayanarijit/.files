SHELL := /bin/bash

.PHONY: all
all:
	curl -L https://nixos.org/nix/install -o install.sh \
		&& sh install.sh --darwin-use-unencrypted-nix-store-volume \
		&& rm -f install.sh
	. ~/.nix-profile/etc/profile.d/nix.sh
	[ -d ~/.config ] || mkdir ~/.config
	ln -sf .profile ~/
	ln -sf .bin ~/
	ln -sf .gitconfig ~/
	ln -sf .direnvrc ~/
	ln -sf .nixpkgs ~/
	for x in .config/*; do ln -sf $$x ~/.config/; done
	. ~/.profile
	nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
	./result/bin/darwin-installer
	rm -rf ./result
	. ~/.profile
	darwin-rebuild switch
	. ~/.nix-profile/etc/profile.d/nix.sh
	which dotsync

.PHONY: sync
sync:
	@git pull --rebase --autostash
	@git add . --all
	@git commit -m "$(shell date)"
	@git push
