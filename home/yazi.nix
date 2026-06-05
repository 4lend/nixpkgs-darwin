{ pkgs, config, lib, ... }:
let
  yazi-plugins-src = pkgs.fetchzip {
    url = "https://github.com/yazi-rs/plugins/archive/refs/heads/main.tar.gz";
    # sha256 = lib.fakeSha256;   # ganti dengan hash yang muncul saat error pertama
    sha256 = "sha256-bqGN6JxbU+/o7TlM/Cm9Qj/s1McA4pB5QWArGZPcme4=";
  };
in
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    settings = {
      manager = {
        ratio = [1 4 4];
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
        sort_case_sensitive = false;
      };
      preview = {
        max_size = 0;
        image_method = "kitty";
        cache_dir = "";
      };
    };

    keymap = {
      manager = [
        { on = ["k"]; run = "arrow -1"; desc = "Up"; }
        { on = ["j"]; run = "arrow 1";  desc = "Down"; }
        { on = ["h"]; run = "leave";    desc = "Go to parent"; }
        { on = ["l"]; run = "enter";    desc = "Enter child"; }
        { on = ["g"]; run = "arrow 0";  desc = "Go to top"; }
        { on = ["G"]; run = "arrow -1"; desc = "Go to bottom"; }
        { on = ["q"]; run = "quit";        desc = "Quit"; }
        { on = ["Q"]; run = "quit --force"; desc = "Force quit"; }
        { on = ["?"]; run = "help";        desc = "Help"; }
        { on = ["R"]; run = "refresh"; desc = "Refresh"; }
        { on = ["<C-l>"]; run = "redraw"; desc = "Redraw"; }
        { on = ["z" "h"]; run = "toggle_hidden"; desc = "Toggle hidden"; }
        { on = ["<C-h>"]; run = "toggle_hidden"; desc = "Toggle hidden"; }
        { on = ["s"]; run = "shell"; desc = "Open shell"; }
        { on = ["S"]; run = "shell --interactive"; desc = "Shell command"; }
        { on = ["!" ]; run = "shell --interactive"; desc = "Shell command"; }
        { on = ["/"]; run = "search"; desc = "Search"; }
        { on = ["n"]; run = "search_next"; desc = "Next"; }
        { on = ["N"]; run = "search_previous"; desc = "Previous"; }
        { on = ["f"]; run = "filter"; desc = "Filter"; }
        { on = ["o"]; run = "sort"; desc = "Sort menu"; }
        { on = ["g" "n"]; run = "tab_create"; desc = "New tab"; }
        { on = ["g" "c"]; run = "tab_close"; desc = "Close tab"; }
        { on = ["<C-n>"]; run = "tab_create"; desc = "New tab"; }
        { on = ["<C-w>"]; run = "tab_close"; desc = "Close tab"; }
        { on = ["<Tab>"]; run = "tab_next"; desc = "Next tab"; }
        { on = ["<S-Tab>"]; run = "tab_previous"; desc = "Prev tab"; }
        { on = ["H"]; run = "back"; desc = "Go back"; }
        { on = ["L"]; run = "forward"; desc = "Go forward"; }
        { on = ["d"]; run = "cut"; desc = "Cut"; }
        { on = ["y"]; run = "yank"; desc = "Yank"; }
        { on = ["p"]; run = "paste"; desc = "Paste"; }
        { on = ["D"]; run = "remove"; desc = "Delete"; }
        { on = ["r"]; run = "rename"; desc = "Rename"; }
        { on = ["e"]; run = "edit"; desc = "Edit"; }
        { on = ["i"]; run = "inspect"; desc = "Inspect"; }
        { on = ["y" "p"]; run = "yank"; desc = "Yank path"; }
        { on = ["y" "d"]; run = "yank --type=dir"; desc = "Yank dir"; }
        { on = ["y" "n"]; run = "yank --type=name"; desc = "Yank name"; }
        { on = ["y" "."]; run = "yank --type=stem"; desc = "Yank no ext"; }
        { on = ["v"]; run = "select_all --toggle"; desc = "Toggle all"; }
        { on = ["V"]; run = "visual_mode"; desc = "Visual mode"; }
        { on = ["<Space>"]; run = "select --toggle"; desc = "Toggle select"; }
        { on = ["m"]; run = "bookmark add"; desc = "Add bookmark"; }
        { on = ["'"]; run = "bookmark jump"; desc = "Jump bookmark"; }
        { on = ["g" "h"]; run = "cd ~"; desc = "Home"; }
        { on = ["g" "e"]; run = "cd /etc"; desc = "/etc"; }
        { on = ["g" "u"]; run = "cd /usr"; desc = "/usr"; }
        { on = ["g" "d"]; run = "cd /dev"; desc = "/dev"; }
        { on = ["g" "o"]; run = "cd /opt"; desc = "/opt"; }
        { on = ["g" "v"]; run = "cd /var"; desc = "/var"; }
        { on = ["g" "p"]; run = "cd /tmp"; desc = "/tmp"; }
        { on = ["g" "r"]; run = "cd /"; desc = "Root"; }
        { on = ["<C-f>"]; run = "plugin fzf"; desc = "fzf finder"; }
        { on = ["<C-g>"]; run = "shell --interactive"; desc = "Shell (custom)"; }
        { on = ["<Up>"]; run = "arrow -1"; }
        { on = ["<Down>"]; run = "arrow 1"; }
        { on = ["<Left>"]; run = "leave"; }
        { on = ["<Right>"]; run = "enter"; }
        { on = ["<Esc>"]; run = "escape"; desc = "Escape"; }
      ];
      pager = [
        { on = ["<Esc>"]; run = "close"; desc = "Close preview"; }
        { on = ["q"]; run = "close"; }
        { on = ["J"]; run = "scroll_down 10"; }
        { on = ["K"]; run = "scroll_up 10"; }
      ];
      tasks = [
        { on = ["<Esc>"]; run = "close"; }
        { on = ["q"]; run = "close"; }
        { on = ["J"]; run = "arrow 1"; }
        { on = ["K"]; run = "arrow -1"; }
      ];
    };

    plugins = {};
    theme = {};
  };

  home.file = {
    ".config/yazi/plugins/fzf".source = "${yazi-plugins-src}/fzf";
    ".config/yazi/plugins/git".source = "${yazi-plugins-src}/git";
    ".config/yazi/plugins/chafa".source = "${yazi-plugins-src}/chafa";
    ".config/yazi/plugins/full-border".source = "${yazi-plugins-src}/full-border";

    ".config/yazi/package.toml".text = ''
      [plugins]
      fzf = "~/.config/yazi/plugins/fzf"
      git = "~/.config/yazi/plugins/git"
      chafa = "~/.config/yazi/plugins/chafa"
      full-border = "~/.config/yazi/plugins/full-border"
    '';
  };
}
