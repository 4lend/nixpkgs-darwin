{ pkgs, config, ... }:

{
  home.username = "alfurqani";
  home.homeDirectory = "/Users/alfurqani";

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "syifa.alfurqoni@gmail.com";
        name = "Alfurqani";
      };
      rerere = {
        enable = true;
      };
      pull = {
        ff = "only";
      };
    };
  };
}
