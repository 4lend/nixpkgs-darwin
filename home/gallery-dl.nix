{ pkgs, config, ... }:

{
  programs.gallery-dl = {
    enable = true;
    package = pkgs.gallery-dl;
    settings = { extractor.base-directory = "~/Downloads"; };
  };
}
