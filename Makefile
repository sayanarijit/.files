SHELL := /bin/bash

.PHONY: all
all:
	curl -L https://nixos.org/nix/install -o install.sh \
		&& sh install.sh --darwin-use-unencrypted-nix-store-volume \
		&& rm -f install.sh
	. ~/.nix-profile/etc/profile.d/nix.sh
	for f in $$(ls -A); do [ -f $$f ] && rm -f ~/$$f; ln -s $$f ~/$$f; done
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
