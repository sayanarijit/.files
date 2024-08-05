SHELL := bash

.PHONY: sync
install:
	@sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
	@sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
	@sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
	@sudo nix-channel --update

.PHONY: sync
sync:
	@git pull --rebase --autostash origin $$(uname)
	@git add . --all
	@git commit -m "$(shell date)"
	@git push -u origin $$(uname)
