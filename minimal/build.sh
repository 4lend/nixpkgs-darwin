	nix build .#darwinConfigurations.4lend.system \
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#4lend
