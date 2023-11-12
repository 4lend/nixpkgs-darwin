deploy:
	nix build .#darwinConfigurations.alfurqani.system \
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#alfurqani

.PHONY: deploy
