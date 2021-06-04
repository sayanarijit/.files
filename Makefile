SHELL := bash

.PHONY: sync
sync:
	@git pull --rebase --autostash origin $$(uname)
	@git add . --all
	@git commit -m "$(shell date)"
	@git push -u origin $$(uname)
