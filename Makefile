SHELL := bash

.PHONY: all
all:
	# Assuming nix is installed
	$(MAKE) clone
	$(MAKE) home-manager
	$(MAKE) docker
	$(MAKE) switch
	$(MAKE) test


.PHONY: clone
clone:
	git clone https://github.com/sayanarijit/.files

.PHONY: nix
nix:
	curl -L https://nixos.org/nix/install | sh
	ln -sf "$$PWD/.nix-channels" ~/

.PHONY: home-manager
home-manager:
	. ./nixpkgs/files/zshrc && nix-channel --update -vvv
	. ./nixpkgs/files/zshrc && nix-shell -vvv '<home-manager>' -A install

.PHONY: switch
switch:
	. ./nixpkgs/files/zshrc && home-manager switch

.PHONY: docker
docker:
	pamac install docker
	sudo usermod -aG docker $$USER

.PHONY: test
test:
	lua -e "print('passed')"
