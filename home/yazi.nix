{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;

    # =======================================================================
    # YAZI SETTINGS (yazi.toml)
    # Referensi opsi lengkap: https://yazi-rs.github.io/docs/configuration/yazi
    # =======================================================================
    settings = {
      manager = {
        cwd = "";
        ratio = [ 1 4 3 ];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = false;
        linemode = "size";
        show_hidden = true;
        show_symlink = true;
        scrolloff = 5;
        mouse_events = [ "click" "scroll" ];
        title_format = "Yazi: {cwd}";
      };

      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        image_filter = "triangle";
        image_quality = 75;
        sixel_fraction = 15;
        ueberzug_scale = 1;
        ueberzug_offset = [ 0 0 0 0 ];
        wrap = "no";
        max_size = 0;
        image_method = "auto";
      };

      opener = {
        edit = [
          { run = ''''${EDITOR:=vi} "$@"$''; desc = "$EDITOR"; block = true; for = "unix"; }
        ];
        "bulk-rename" = [
          { run = ''nvim "$@"''; desc = "Bulk Rename with Neovim"; block = true; for = "unix"; }
        ];
        play = [
          { run = ''mpv "$@"''; orphan = true; for = "unix"; }
        ];
        open = [
          { run = ''xdg-open "$1"''; desc = "Open"; for = "linux"; }
          { run = ''open "$@"''; desc = "Open"; for = "macos"; }
        ];
        reveal = [
          { run = ''open -R "$1"''; desc = "Reveal"; for = "macos"; }
        ];
        extract = [
          { run = ''ya pub extract --list "$@"''; desc = "Extract here"; for = "unix"; }
        ];
      };

      open = {
        rules = [
          { name = "bulk-rename.txt"; use = [ "bulk-rename" ]; }
          { name = "*/"; use = [ "edit" "open" "reveal" ]; }
          { mime = "text/*"; use = [ "edit" "reveal" ]; }
          { mime = "video/*"; use = [ "play" "reveal" ]; }
          { mime = "audio/*"; use = [ "play" "reveal" ]; }
          { mime = "inode/x-empty"; use = [ "edit" "reveal" ]; }
          { mime = "application/*zip"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-tar"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-bzip2"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-7z-compressed"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-rar"; use = [ "extract" "reveal" ]; }
          { mime = "*"; use = [ "open" "reveal" ]; }
        ];
      };

      tasks = {
        micro_workers = 10;
        macro_workers = 25;
        bizarre_retry = 5;
        image_alloc = 536870912;
        image_bound = [ 0 0 ];
        suppress_preload = false;
      };

      plugin = {
        preloaders = [
          { mime = "image/{avif,hei?,jxl,webp}"; cond = "!mime"; run = "magick"; }
          { mime = "image/*"; run = "image"; }
          { mime = "video/*"; run = "video"; }
          { mime = "application/pdf"; run = "pdf"; }
          { mime = "font/*"; run = "font"; }
          { mime = "application/vnd.ms-opentype"; run = "font"; }
        ];
        previewers = [
          { name = "*/"; run = "folder"; sync = true; }
          { mime = "text/*"; run = "code"; }
          { mime = "*/xml"; run = "code"; }
          { mime = "*/javascript"; run = "code"; }
          { mime = "*/x-wine-extension-ini"; run = "code"; }
          { mime = "application/json"; run = "json"; }
          { mime = "image/{avif,hei?,jxl,webp}"; cond = "!mime"; run = "magick"; }
          { mime = "image/*"; run = "image"; }
          { mime = "video/*"; run = "video"; }
          { mime = "application/pdf"; run = "pdf"; }
          { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma}"; run = "archive"; }
          { mime = "font/*"; run = "font"; }
          { mime = "application/vnd.ms-opentype"; run = "font"; }
          { mime = "inode/x-empty"; run = "empty"; }
          { fallback = true; run = "file"; }
        ];
      };

      input = {
        cursor_blink = false;
        cd_title = "Change directory:";
        cd_origin = "top-center";
        cd_offset = [ 0 2 50 3 ];
        create_title = "Create:";
        create_origin = "top-center";
        create_offset = [ 0 2 50 3 ];
        rename_title = "Rename:";
        rename_origin = "hovered";
        rename_offset = [ 0 1 50 3 ];
        filter_title = "Filter:";
        filter_origin = "top-center";
        filter_offset = [ 0 2 50 3 ];
        find_title = [ "Find next:" "Find previous:" ];
        find_origin = "top-center";
        find_offset = [ 0 2 50 3 ];
        search_title = "Search via {n}:";
        search_origin = "top-center";
        search_offset = [ 0 2 50 3 ];
        shell_title = [ "Shell:" "Shell (block):" ];
        shell_origin = "top-center";
        shell_offset = [ 0 2 50 3 ];
      };

      confirm = {
        trash_title = "Trash {n} selected file{s}?";
        trash_origin = "center";
        trash_offset = [ 0 0 70 20 ];
        delete_title = "Permanently delete {n} selected file{s}?";
        delete_origin = "center";
        delete_offset = [ 0 0 70 20 ];
        overwrite_title = "Overwrite file?";
        overwrite_content = "Will overwrite {n} file{s}.";
        overwrite_origin = "center";
        overwrite_offset = [ 0 0 50 15 ];
        quit_title = "Quit?";
        quit_content = "The following task is still running, are you sure you want to quit?";
        quit_origin = "center";
        quit_offset = [ 0 0 50 15 ];
      };

      select = {
        open_title = "Open with:";
        open_origin = "hovered";
        open_offset = [ 0 1 50 7 ];
      };

      log = {
        enabled = false;
      };
    };

    # =======================================================================
    # YAZI KEYMAPS (keymap.toml)
    # =======================================================================
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

          # Create File/Folder (Ranger style)
          { on = [ "m" "k" "d" ]; run = "create --dir"; desc = "Create a directory"; }

          # Copy, Cut, Paste (Ranger style)
          { on = [ "y" "y" ]; run = "yank"; desc = "Copy file"; }
          { on = [ "d" "d" ]; run = "yank --cut"; desc = "Cut / Move file"; }
          { on = [ "p" "p" ]; run = "paste"; desc = "Paste file"; }
          { on = [ "p" "O" ]; run = "paste --force"; desc = "Paste (Overwrite)"; }

          # Jumping around (from ranger)
          { on = [ "g" "h" ]; run = "cd ~"; desc = "Go home"; }
          { on = [ "g" "e" ]; run = "cd /etc"; desc = "Go to /etc"; }
          { on = [ "g" "u" ]; run = "cd /usr"; desc = "Go to /usr"; }
          { on = [ "g" "d" ]; run = "cd /dev"; desc = "Go to /dev"; }
          { on = [ "g" "o" ]; run = "cd /opt"; desc = "Go to /opt"; }
          { on = [ "g" "v" ]; run = "cd /Volumes"; desc = "Go to /Volumes"; }
          { on = [ "g" "m" ]; run = "cd /media"; desc = "Go to /media"; }
          { on = [ "g" "M" ]; run = "cd /mnt"; desc = "Go to /mnt"; }
          { on = [ "g" "s" ]; run = "cd /srv"; desc = "Go to /srv"; }
          { on = [ "g" "p" ]; run = "cd /tmp"; desc = "Go to /tmp"; }
          { on = [ "g" "r" ]; run = "cd /"; desc = "Go to /"; }
          { on = [ "g" "/" ]; run = "cd /"; desc = "Go to /"; }

          # Directory Sizes
          { on = [ "d" "s" ]; run = "shell 'du -sh \"$@\" && printf \"\\nTekan Enter untuk kembali...\\n\" && read' --block --confirm"; desc = "Get selected folder size"; }
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
          { on = [ "b" "r" ]; run = "rename"; desc = "Bulk Rename"; }

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

          # Sorting (using official Yazi flags)
          { on = [ "o" "r" ]; run = "sort random"; desc = "Sort random"; }
          { on = [ "o" "s" ]; run = "sort size"; desc = "Sort by size"; }
          { on = [ "o" "b" ]; run = "sort alphabetical"; desc = "Sort by basename"; }
          { on = [ "o" "n" ]; run = "sort natural"; desc = "Sort naturally"; }
          { on = [ "o" "m" ]; run = "sort mtime"; desc = "Sort by mtime"; }
          { on = [ "o" "c" ]; run = "sort mtime"; desc = "Sort by ctime (fallback to mtime)"; }
          { on = [ "o" "a" ]; run = "sort btime"; desc = "Sort by atime"; }
          { on = [ "o" "e" ]; run = "sort extension"; desc = "Sort by extension"; }
          { on = [ "o" "S" ]; run = "sort size --reverse"; desc = "Sort by size reverse"; }
          { on = [ "o" "B" ]; run = "sort alphabetical --reverse"; desc = "Sort by basename reverse"; }
          { on = [ "o" "N" ]; run = "sort natural --reverse"; desc = "Sort naturally reverse"; }
          { on = [ "o" "M" ]; run = "sort mtime --reverse"; desc = "Sort by mtime reverse"; }
          { on = [ "o" "C" ]; run = "sort mtime --reverse"; desc = "Sort by ctime reverse"; }
          { on = [ "o" "A" ]; run = "sort btime --reverse"; desc = "Sort by atime reverse"; }
          { on = [ "o" "E" ]; run = "sort extension --reverse"; desc = "Sort by extension reverse"; }

          # Linemode
          { on = [ "M" "s" ]; run = "linemode size"; desc = "Linemode size"; }
          { on = [ "M" "p" ]; run = "linemode permissions"; desc = "Linemode permissions"; }
          { on = [ "M" "m" ]; run = "linemode mtime"; desc = "Linemode mtime"; }

          # Settings toggles
          { on = [ "z" "h" ]; run = "hidden toggle"; desc = "Toggle hidden"; }
          { on = [ "<C-h>" ]; run = "hidden toggle"; desc = "Toggle hidden"; }
          { on = [ "z" "d" ]; run = "sort --dir-first"; desc = "Toggle sort directories first"; }

          # Tabs (similar to ranger)
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