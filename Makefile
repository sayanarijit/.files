.PHONY: all
all:
        curl -L https://nixos.org/nix/install | sh
	for f in $(ls -d .*); do [ -f $f ] && ln -s $f ~/; done
        mkdir ~/.config || true
	for d in $(ls -d .config/*); do [ -d $d ] && ln -s .config/$d ~/.config/; done
	ln -s .config/alacritty ~/.config/
	ln -s .config/nvim ~/.config/
	ln -s .config/tmunixnator ~/.config/
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
	@git commit -m "${NOW}"
	@git push
