{ pkgs, nixpkgs-unstable, ... }:

let
  yazi-unstable = nixpkgs-unstable.legacyPackages.${pkgs.system}.yazi;
  yazi-plugins-src = pkgs.fetchzip {
    url = "https://github.com/yazi-rs/plugins/archive/refs/heads/main.tar.gz";
    sha256 = "sha256-bqGN6JxbU+/o7TlM/Cm9Qj/s1McA4pB5QWArGZPcme4=";
  };
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    package = yazi-unstable;

    settings = {
      manager = {
        ratio = [1 4 4];
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
        sort_reverse = false;
        sort_case_sensitive = false;
        linemode = "size";
      };
      preview = {
        max_size = 0;
        image_method = "kitty";
        cache_dir = "";
      };
      advanced = {
        terminal_timeout = 5000;   # fix untuk tmux
      };
    };

    keymap = {
      manager = [
        # ========== NAVIGASI DASAR ==========
        { on = ["k"]; run = "arrow -1"; desc = "Up"; }
        { on = ["j"]; run = "arrow 1"; desc = "Down"; }
        { on = ["h"]; run = "leave"; desc = "Go to parent"; }
        { on = ["l"]; run = "enter"; desc = "Enter child"; }
        { on = ["gg"]; run = "arrow 0"; desc = "Top"; }
        { on = ["G"]; run = "arrow -1"; desc = "Bottom"; }
        { on = ["<C-u>"]; run = "arrow -0.5"; desc = "Half page up"; }
        { on = ["<C-d>"]; run = "arrow 0.5"; desc = "Half page down"; }
        { on = ["<C-f>"]; run = "arrow 1.0 pages=true"; desc = "Page down"; }
        { on = ["<C-b>"]; run = "arrow -1.0 pages=true"; desc = "Page up"; }

        # ========== TAB (pengganti dual-pane) ==========
        { on = ["<C-n>"]; run = "tab_create"; desc = "New tab"; }
        { on = ["<C-w>"]; run = "tab_close"; desc = "Close tab"; }
        { on = ["<Tab>"]; run = "tab_next"; desc = "Next tab"; }
        { on = ["<S-Tab>"]; run = "tab_previous"; desc = "Prev tab"; }
        { on = ["gt"]; run = "tab_next"; desc = "Next tab (vim)"; }
        { on = ["gT"]; run = "tab_previous"; desc = "Prev tab (vim)"; }
        { on = ["1"]; run = "tab_open 1"; desc = "Tab 1"; }
        { on = ["2"]; run = "tab_open 2"; desc = "Tab 2"; }
        { on = ["3"]; run = "tab_open 3"; desc = "Tab 3"; }
        { on = ["4"]; run = "tab_open 4"; desc = "Tab 4"; }
        { on = ["5"]; run = "tab_open 5"; desc = "Tab 5"; }
        { on = ["6"]; run = "tab_open 6"; desc = "Tab 6"; }
        { on = ["7"]; run = "tab_open 7"; desc = "Tab 7"; }
        { on = ["8"]; run = "tab_open 8"; desc = "Tab 8"; }
        { on = ["9"]; run = "tab_open 9"; desc = "Tab 9"; }

        # ========== FILE OPERATIONS ==========
        { on = ["dd"]; run = "cut"; desc = "Cut"; }
        { on = ["yy"]; run = "yank"; desc = "Copy"; }
        { on = ["p"]; run = "paste"; desc = "Paste"; }
        { on = ["P"]; run = "paste --overwrite"; desc = "Paste (overwrite)"; }
        { on = ["dD"]; run = "remove"; desc = "Delete permanently"; }
        { on = ["dT"]; run = "trash"; desc = "Move to trash"; }
        { on = ["r"]; run = "rename"; desc = "Rename"; }
        { on = ["a"]; run = "rename --append"; desc = "Rename (append)"; }

        # ========== YANK PATH/NAME ==========
        { on = ["y" "p"]; run = "yank"; desc = "Yank path"; }
        { on = ["y" "d"]; run = "yank --type=dir"; desc = "Yank dir"; }
        { on = ["y" "n"]; run = "yank --type=name"; desc = "Yank name"; }
        { on = ["y" "."]; run = "yank --type=stem"; desc = "Yank no ext"; }

        # ========== MARKING ==========
        { on = ["V"]; run = "visual_mode"; desc = "Visual mode"; }
        { on = ["v"]; run = "select_all --toggle"; desc = "Toggle all marks"; }
        { on = ["<Space>"]; run = "select --toggle"; desc = "Toggle mark"; }

        # ========== SEARCH & FILTER ==========
        { on = ["/"]; run = "search"; desc = "Search"; }
        { on = ["n"]; run = "search_next"; desc = "Next match"; }
        { on = ["N"]; run = "search_prev"; desc = "Prev match"; }
        { on = ["f"]; run = "filter"; desc = "Filter (show only matches)"; }

        # ========== SORTING ==========
        { on = ["o" "r"]; run = "sort toggle_reverse"; desc = "Toggle reverse sort"; }
        { on = ["o" "s"]; run = "sort size"; desc = "Sort by size"; }
        { on = ["o" "b"]; run = "sort basename"; desc = "Sort by name"; }
        { on = ["o" "n"]; run = "sort natural"; desc = "Sort natural"; }
        { on = ["o" "m"]; run = "sort modified"; desc = "Sort by modified time"; }

        # ========== TOGGLES ==========
        { on = ["z" "h"]; run = "toggle_hidden"; desc = "Toggle hidden files"; }
        { on = ["z" "d"]; run = "toggle_dirstack"; desc = "Toggle dirs first"; }

        # ========== QUICK PATHS ==========
        { on = ["g" "h"]; run = "cd ~"; desc = "Home"; }
        { on = ["g" "e"]; run = "cd /etc"; desc = "/etc"; }
        { on = ["g" "u"]; run = "cd /usr"; desc = "/usr"; }
        { on = ["g" "d"]; run = "cd /dev"; desc = "/dev"; }
        { on = ["g" "o"]; run = "cd /opt"; desc = "/opt"; }
        { on = ["g" "v"]; run = "cd /var"; desc = "/var"; }
        { on = ["g" "p"]; run = "cd /tmp"; desc = "/tmp"; }
        { on = ["g" "r"]; run = "cd /"; desc = "Root"; }

        # ========== MISC ==========
        { on = ["q"]; run = "quit"; desc = "Quit"; }
        { on = ["Q"]; run = "quit --force"; desc = "Force quit"; }
        { on = ["R"]; run = "refresh"; desc = "Refresh"; }
        { on = ["<C-l>"]; run = "redraw"; desc = "Redraw"; }
        { on = ["?"]; run = "help"; desc = "Help"; }
        { on = ["i"]; run = "inspect"; desc = "Inspect file"; }
        { on = ["E"]; run = "edit"; desc = "Edit file"; }
        { on = ["s"]; run = "shell"; desc = "Open shell"; }
        { on = ["S"]; run = "shell --interactive"; desc = "Interactive shell"; }
        { on = ["!"]; run = "shell --interactive"; desc = "Shell command"; }
        { on = ["m"]; run = "bookmark add"; desc = "Add bookmark"; }
        { on = ["'"]; run = "bookmark jump"; desc = "Jump bookmark"; }
      ];
      pager = [
        { on = ["<Esc>"]; run = "close"; desc = "Close preview"; }
        { on = ["q"]; run = "close"; }
        { on = ["J"]; run = "scroll_down 10"; desc = "Scroll down"; }
        { on = ["K"]; run = "scroll_up 10"; desc = "Scroll up"; }
        { on = ["<C-d>"]; run = "scroll_down 0.5 pages=true"; desc = "Half page down"; }
        { on = ["<C-u>"]; run = "scroll_up 0.5 pages=true"; desc = "Half page up"; }
        { on = ["gg"]; run = "scroll_to 0"; desc = "Go to top"; }
        { on = ["G"]; run = "scroll_to -1"; desc = "Go to bottom"; }
      ];
    };

    theme = {
      syntax = {
        background = "#1a1b26";
        foreground = "#c0caf5";
        selection = "#33467c";
        comment = "#565f89";
        cyan = "#7dcfff";
        green = "#9ece6a";
        orange = "#ff9e64";
        pink = "#bb9af7";
        purple = "#9d7cd8";
        red = "#f7768e";
        yellow = "#e0af68";
      };
    };

    plugins = {};
  };

  # Pasang plugin fzf dan git secara manual
  home.file = {
    ".config/yazi/plugins/fzf".source = "${yazi-plugins-src}/fzf";
    ".config/yazi/plugins/git".source = "${yazi-plugins-src}/git";
  };
}
