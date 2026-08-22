
{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
        linemode = "size";
      };
      preview = {
        max_size = 0;
        image_method = "auto";
      };
    };

    # Only use commands verified to exist in official docs
    keymap = {
      manager = [
        # Navigation (confirmed)
        { on = "k"; run = "arrow -1"; desc = "Up"; }
        { on = "j"; run = "arrow 1"; desc = "Down"; }
        { on = "h"; run = "leave"; desc = "Parent"; }
        { on = "l"; run = "enter"; desc = "Enter"; }
        
        # File ops (confirmed)
        { on = "dd"; run = "cut"; desc = "Cut"; }
        { on = "yy"; run = "yank"; desc = "Copy"; }
        { on = "pp"; run = "paste"; desc = "Paste"; }
        
        # Help (you can press ? inside yazi to see all valid commands)
        { on = "?"; run = "help"; desc = "Help"; }
        { on = "q"; run = "quit"; desc = "Quit"; }
      ];
    };
 };
}
