.PHONY: all
all:
	sh < (curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
	for f in $(ls -d .*); do [ -f $f ] && ln -s $f ~/; done
	ln -s .bin ~/
	ln -s .nixpkgs ~/
	mkdir ~/.config || true
	for d in $(ls -d .config/*); do [ -d .config/$d ] && ln -s .config/$d ~/.config/; done
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
