{ pkgs, config, ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      # sub-auto = "all";
      sub-font = "JetBrainsMonoNL Nerd Font";
      sub-font-size = 30;  # 38;
      sub-color = "#FFFE25";  # yellow  # #FFFFFF - white
	  # sub-border-color = "#000000";  # black  # #202020
	  # sub-border-size = "4";  # default
	  # sub-bold = "no";
	  # sub-pos = 98;
      sid = 1;
      sub-auto = "fuzzy";
      window = "fullscreen";
      speed = 1.50;
      playback = "save-position-on-quit";
	    fullscreen = "yes";
	    save-position-on-quit = "yes";
	    sub-ass-override = "force";
      autofit = "100%";
    };
  };
}