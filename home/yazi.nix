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

    keymap = {
      mgr = {
        prepend_keymap = [
          # Jumping around (from ranger)
          { on = [ "g" "h" ]; run = "cd ~"; desc = "Go home"; }
          { on = [ "g" "e" ]; run = "cd /etc"; desc = "Go to /etc"; }
          { on = [ "g" "u" ]; run = "cd /usr"; desc = "Go to /usr"; }
          { on = [ "g" "d" ]; run = "cd /dev"; desc = "Go to /dev"; }
          { on = [ "g" "o" ]; run = "cd /opt"; desc = "Go to /opt"; }
          { on = [ "g" "v" ]; run = "cd /var"; desc = "Go to /var"; }
          { on = [ "g" "m" ]; run = "cd /media"; desc = "Go to /media"; }
          { on = [ "g" "M" ]; run = "cd /mnt"; desc = "Go to /mnt"; }
          { on = [ "g" "s" ]; run = "cd /srv"; desc = "Go to /srv"; }
          { on = [ "g" "p" ]; run = "cd /tmp"; desc = "Go to /tmp"; }
          { on = [ "g" "r" ]; run = "cd /"; desc = "Go to /"; }
          { on = [ "g" "/" ]; run = "cd /"; desc = "Go to /"; }

          # External Programs / File Operations
          { on = [ "d" "u" ]; run = "shell 'du -d 1 -h' --block --confirm"; desc = "Show directory sizes"; }
          { on = [ "d" "U" ]; run = "shell 'du -d 1 -h | sort -rh' --block --confirm"; desc = "Show directory sizes sorted"; }

          # Delete and Trash
          { on = [ "d" "D" ]; run = "remove --permanently"; desc = "Permanently delete"; }
          { on = [ "d" "T" ]; run = "remove"; desc = "Trash"; }

          # Rename
          { on = [ "c" "w" ]; run = "rename"; desc = "Rename"; }
          { on = "a"; run = "rename --cursor=before_ext"; desc = "Rename append"; }
          { on = "A"; run = "rename --cursor=end"; desc = "Rename append at end"; }
          { on = "I"; run = "rename --cursor=start"; desc = "Rename at start"; }
          { on = [ "b" "r" ]; run = "shell 'bulkrename' --block --confirm"; desc = "Bulk Rename"; }

          # Copy Paths
          { on = [ "y" "p" ]; run = "copy path"; desc = "Copy absolute path"; }
          { on = [ "y" "d" ]; run = "copy dirname"; desc = "Copy directory path"; }
          { on = [ "y" "n" ]; run = "copy filename"; desc = "Copy filename"; }
          { on = [ "y" "." ]; run = "copy name-without-ext"; desc = "Copy filename without extension"; }

          # Chmod (Interactive)
          { on = "="; run = "shell 'chmod ' --interactive --cursor=6"; desc = "Chmod"; }

          # Find / FZF
          { on = [ "<C-f>" ]; run = "shell 'ya emit reveal \"$(fzf)\"' --block --confirm"; desc = "FZF select"; }
          { on = [ "<C-g>" ]; run = "shell 'ya emit reveal \"$(fzf)\"' --block --confirm"; desc = "FZF locate"; }

          # Sorting
          { on = [ "o" "r" ]; run = "sort random"; desc = "Sort random"; }
          { on = [ "o" "s" ]; run = "sort size"; desc = "Sort by size"; }
          { on = [ "o" "b" ]; run = "sort alphabetical"; desc = "Sort by basename"; }
          { on = [ "o" "n" ]; run = "sort natural"; desc = "Sort naturally"; }
          { on = [ "o" "m" ]; run = "sort mtime"; desc = "Sort by mtime"; }
          { on = [ "o" "c" ]; run = "sort mtime"; desc = "Sort by ctime (fallback to mtime)"; }
          { on = [ "o" "a" ]; run = "sort btime"; desc = "Sort by atime (fallback to btime)"; }
          { on = [ "o" "e" ]; run = "sort extension"; desc = "Sort by extension"; }
          { on = [ "o" "S" ]; run = "sort size --reverse"; desc = "Sort by size reverse"; }
          { on = [ "o" "B" ]; run = "sort alphabetical --reverse"; desc = "Sort by basename reverse"; }
          { on = [ "o" "N" ]; run = "sort natural --reverse"; desc = "Sort naturally reverse"; }
          { on = [ "o" "M" ]; run = "sort mtime --reverse"; desc = "Sort by mtime reverse"; }
          { on = [ "o" "C" ]; run = "sort mtime --reverse"; desc = "Sort by ctime reverse (fallback to mtime)"; }
          { on = [ "o" "A" ]; run = "sort btime --reverse"; desc = "Sort by atime reverse (fallback to btime)"; }
          { on = [ "o" "E" ]; run = "sort extension --reverse"; desc = "Sort by extension reverse"; }

          # Linemode
          { on = [ "M" "s" ]; run = "linemode size"; desc = "Linemode size"; }
          { on = [ "M" "p" ]; run = "linemode permissions"; desc = "Linemode permissions"; }
          { on = [ "M" "m" ]; run = "linemode mtime"; desc = "Linemode mtime"; }

          # Settings toggles
          { on = [ "z" "h" ]; run = "hidden toggle"; desc = "Toggle hidden"; }
          { on = "<C-h>"; run = "hidden toggle"; desc = "Toggle hidden"; }
          { on = [ "z" "d" ]; run = "sort_dir_first toggle"; desc = "Toggle sort directories first"; }

          # Tabs (similar to ranger)
          { on = "<C-n>"; run = "tab_create --current"; desc = "Create new tab"; }
          { on = [ "g" "n" ]; run = "tab_create --current"; desc = "Create new tab"; }
          { on = "<C-w>"; run = "close"; desc = "Close tab"; }
          { on = "<Tab>"; run = "tab_switch 1 --relative"; desc = "Next tab"; }
          { on = "<S-Tab>"; run = "tab_switch -1 --relative"; desc = "Previous tab"; }
          { on = [ "g" "t" ]; run = "tab_switch 1 --relative"; desc = "Next tab"; }
          { on = [ "g" "T" ]; run = "tab_switch -1 --relative"; desc = "Previous tab"; }
        ];
      };
    };
  };
}
