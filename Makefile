SHELL := bash

.PHONY: all
all:
	# Assuming nix is installed
	$(MAKE) clone
	$(MAKE) home-manager
	$(MAKE) switch
	$(MAKE) test


.PHONY: clone
clone:
	git clone https://github.com/sayanarijit/.files

.PHONY: nix
nix:
	curl -L https://nixos.org/nix/install | sh

~/.nix-channels:
	ln -sf "$$PWD/.nix-channels" ~/
	nix-channel --update -vvv

.PHONY: home-manager
home-manager: ~/.nix-channels
	nix-shell -vvv '<home-manager>' -A install

~/.config/nixpkgs:
	ln -sf nixpkgs ~/.config/

.PHONY: switch
switch: ~/.config/nixpkgs
	home-manager switch

.PHONY: docker
docker:
	sudo pamac install docker
	sudo usermod -aG docker $$USER

.PHONY: test
test:
	lua -e "print('passed')"

.PHONY: diff
diff:
	@cp -vf ~/.config/alacritty/alacritty.yml nixpkgs/files/alacritty/alacritty.yml
	@cp -vf ~/.config/kglobalshortcutsrc nixpkgs/files/kglobalshortcutsrc
	@cp -vf ~/.config/nvim/init.vim nixpkgs/files/nvim/init.vim
	@git diff

.PHONY: reset
reset:
	@git reset --hard
	@git diff

.PHONY: sync
sync:
	@git pull --rebase --autostash origin $$(uname)
	@git add . --all
	@git commit -m "$(shell date)"
	@git push -u origin $$(uname)
