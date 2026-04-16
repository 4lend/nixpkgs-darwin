	nix build .#darwinConfigurations.alfurqani.system \
	   --extra-experimental-features 'nix-command flakes'

	sudo ./result/sw/bin/darwin-rebuild switch --flake .#alfurqani
