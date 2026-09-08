{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    shellWrapperName = "y"; # opsional, jika ingin command `y`

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
        linemode = "size";
      };
      preview = {
        max_size = 0;
        # image_method tidak diperlukan lagi
      };
    };

    keymap = {
      manager = {
        prepend_keymap = [
          # Basic Operations
          { on = [ "Q" ]; run = "quit"; desc = "Quit"; }
          { on = [ "q" ]; run = "close"; desc = "Close tab or quit"; }
          { on = [ "<Space>" ]; run = "toggle"; desc = "Toggle selection"; }
          { on = [ "v" ]; run = "toggle_all"; desc = "Toggle all selection"; }
          { on = [ "V" ]; run = "visual_mode"; desc = "Visual mode"; }
          { on = [ "S" ]; run = "shell \"$SHELL\" --block --confirm"; desc = "Open shell"; }
          { on = [ "i" ]; run = "open --interactive"; desc = "Open interactively"; }

          # Jumping around
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

          # Directory Sizes
          { on = [ "d" "u" ]; run = "shell 'du -d 1 -h' --block --confirm"; desc = "Show directory sizes"; }
          { on = [ "d" "U" ]; run = "shell 'du -d 1 -h | sort -rh' --block --confirm"; desc = "Show directory sizes sorted"; }

          # Delete and Trash
          { on = [ "d" "D" ]; run = "remove --permanently"; desc = "Permanently delete"; }
          { on = [ "d" "T" ]; run = "remove"; desc = "Trash"; }

          # Rename
          { on = [ "c" "w" ]; run = "rename"; desc = "Rename"; }
          { on = [ "a" ]; run = "rename --cursor=before_ext"; desc = "Rename append"; }
          { on = [ "A" ]; run = "rename --cursor=end"; desc = "Rename append at end"; }
          { on = [ "I" ]; run = "rename --cursor=start"; desc = "Rename at start"; }
          { on = [ "b" "r" ]; run = "bulkrename"; desc = "Bulk Rename"; }  # ← diperbaiki

          # Copy Paths
          { on = [ "y" "p" ]; run = "copy path"; desc = "Copy absolute path"; }
          { on = [ "y" "d" ]; run = "copy dirname"; desc = "Copy directory path"; }
          { on = [ "y" "n" ]; run = "copy filename"; desc = "Copy filename"; }
          { on = [ "y" "." ]; run = "copy name-without-ext"; desc = "Copy filename without extension"; }

          # Chmod
          { on = [ "=" ]; run = "shell 'chmod +x \"$@\"' --block --confirm"; desc = "Chmod"; }

          # FZF Integration
          { on = [ "<C-f>" ]; run = "shell 'res=\"$(fzf)\" && ya emit reveal \"$res\"' --block --confirm"; desc = "FZF select"; }
          { on = [ "<C-g>" ]; run = "shell 'res=\"$(fzf)\" && ya emit reveal \"$res\"' --block --confirm"; desc = "FZF locate"; }

          # Sorting (menggunakan key yang valid)
          { on = [ "o" "r" ]; run = "sort random"; desc = "Sort random"; }
          { on = [ "o" "s" ]; run = "sort size"; desc = "Sort by size"; }
          { on = [ "o" "b" ]; run = "sort alphabetical"; desc = "Sort by basename"; }
          { on = [ "o" "n" ]; run = "sort natural"; desc = "Sort naturally"; }
          { on = [ "o" "m" ]; run = "sort mtime"; desc = "Sort by mtime"; }
          { on = [ "o" "e" ]; run = "sort extension"; desc = "Sort by extension"; }
          { on = [ "o" "a" ]; run = "sort btime"; desc = "Sort by birth time"; }  # ← ganti atime menjadi btime
          # Hapus binding untuk ctime karena tidak ada key sort tersebut
          # { on = [ "o" "c" ]; ... }  # dihilangkan

          { on = [ "o" "S" ]; run = "sort size --reverse"; desc = "Sort by size reverse"; }
          { on = [ "o" "B" ]; run = "sort alphabetical --reverse"; desc = "Sort by basename reverse"; }
          { on = [ "o" "N" ]; run = "sort natural --reverse"; desc = "Sort naturally reverse"; }
          { on = [ "o" "M" ]; run = "sort mtime --reverse"; desc = "Sort by mtime reverse"; }
          { on = [ "o" "E" ]; run = "sort extension --reverse"; desc = "Sort by extension reverse"; }
          { on = [ "o" "A" ]; run = "sort btime --reverse"; desc = "Sort by birth time reverse"; }  # ← perbaiki
          # Hapus juga reverse untuk ctime

          # Linemode
          { on = [ "M" "s" ]; run = "linemode size"; desc = "Linemode size"; }
          { on = [ "M" "p" ]; run = "linemode permissions"; desc = "Linemode permissions"; }
          { on = [ "M" "m" ]; run = "linemode mtime"; desc = "Linemode mtime"; }

          # Settings toggles
          { on = [ "z" "h" ]; run = "hidden toggle"; desc = "Toggle hidden"; }
          { on = [ "<C-h>" ]; run = "hidden toggle"; desc = "Toggle hidden"; }
          { on = [ "z" "d" ]; run = "sort --dir-first"; desc = "Toggle sort directories first"; }

          # Tabs
          { on = [ "<C-n>" ]; run = "tab_create --current"; desc = "Create new tab"; }
          { on = [ "g" "n" ]; run = "tab_create --current"; desc = "Create new tab"; }
          { on = [ "<C-w>" ]; run = "close"; desc = "Close tab"; }
          { on = [ "<Tab>" ]; run = "tab_switch 1 --relative"; desc = "Next tab"; }
          { on = [ "<S-Tab>" ]; run = "tab_switch -1 --relative"; desc = "Previous tab"; }
          { on = [ "g" "t" ]; run = "tab_switch 1 --relative"; desc = "Next tab"; }
          { on = [ "g" "T" ]; run = "tab_switch -1 --relative"; desc = "Previous tab"; }
        ];
      };
    };
  };
}
