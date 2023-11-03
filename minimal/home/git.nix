{ pkgs, config, ... }:

{
  home.username = "alfurqani";
  home.homeDirectory = "/Users/alfurqani";
  home.stateVersion = "23.05";

  programs = { 
    git = {
      enable = true;
      userEmail = "syifa.alfurqoni@gmail.com";
      userName = "Alfurqani";
      ignores = [ "result" ];
      # signing.key = "553E0E6F94B2548E";
      # signing.signByDefault = true;
      # aliases = {
      #   co = "checkout";
      #   lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches";
      # };
      extraConfig = {
        rerere.enable = true;
        pull.ff = "only";
      };

      diff-so-fancy = {
        enable = true;
        changeHunkIndicators = true;
        markEmptyLines = true;
        # rulerWidth = "";
        stripLeadingSymbols = true;
        useUnicodeRuler = true;
        # pagerOpts = {};
      };
    };
    # git.diff-so-fancy = {
    #   enable = true;
    #   changeHunkIndicators = true;
    #   markEmptyLines = true;
    #   rulerWidth = "";
    #   stripLeadingSymbols = true;
    #   useUnicodeRuler = true;
    #   pagerOpts = {};
    # };
  };
}
