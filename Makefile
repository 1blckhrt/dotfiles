.PHONY: switch
switch:
	home-manager switch --flake .#laptop -b backup

.PHONY: clean
clean:
	nix-collect-garbage -d

.PHONY: switch-shell
switch-shell:
	echo "This will ask you for your sudo password. Afterwards, you will need to reboot to have the changes applied."
	@echo "/home/blckhrt/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
	@chsh -s $(which zsh)
