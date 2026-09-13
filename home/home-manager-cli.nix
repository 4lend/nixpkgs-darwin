{ pkgs, home-manager, ... }:

{
  home.file.".local/bin/hm" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      exec ${home-manager.packages.${pkgs.stdenv.hostPlatform.system}.home-manager}/bin/home-manager "$@"
    '';
  };
}
