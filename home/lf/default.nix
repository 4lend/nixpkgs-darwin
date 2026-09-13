{ ... }:

{
  imports = [
    ./icons.nix
    ./colors.nix
  ];

  programs.lf = {
    enable = true;

    extraConfig = ''
    '';
  };
}
