.PHONY: all
all:
	$(MAKE) clone
	$(MAKE) nix
	$(MAKE) home-manager
	$(MAKE) docker
	$(MAKE) switch


.PHONY: clone
clone:
	git clone https://github.com/sayanarijit/.files

.PHONY: nix
nix:
	curl -L https://nixos.org/nix/install | sh

.PHONY: home-manager
home-manager:
	source ./nixpkgs/files/zshrc && nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	source ./nixpkgs/files/zshrc && nix-channel --update
	source ./nixpkgs/files/zshrc && nix-shell '<home-manager>' -A install

.PHONY: switch
switch:
	source ./nixpkgs/files/zshrc && home-manager switch

.PHONY: docker
docker:
	pamac install docker
	sudo usermod -aG docker $$USER
