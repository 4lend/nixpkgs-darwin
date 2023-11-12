	nix build .#darwinConfigurations.alfurqani.system \
	   --extra-experimental-features 'nix-command flakes' --show-trace

	./result/sw/bin/darwin-rebuild switch --flake .#alfurqani
