{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Alfurqani";
    userEmail = "syifa.alfurqoni@gmail.com";
    extraConfig = ''
      [rerere]
        enable = true
      [pull]
        ff = only
    '';
    # ignores = [ "result" ];
    # signing.key = "...";
    # signing.signByDefault = true;
  };
}
