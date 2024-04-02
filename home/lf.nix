{ pkgs, config, ... }:

let

in {
  programs.lf = {
    enable = true;
    extraConfig = ''
      -- General settings
      set shell sh
      set shellopts '-eu'
      set ifs "\n"
      set icons true
      set period 1
      set hiddenfiles ".*:*.aux:*.log:*.bbl:*.bcf:*.blg:*.run.xml"
      set cleaner '~/.config/lf/cleaner'
      set previewer '~/.config/lf/previewer'
    '';

    # keybindings = { 
    #   D = "trash"; 
    #   e = "edit";
    #   q = "quit";
    #   Q = "quitall";
    #   R = "reload_cwd";

    #   F = "set freeze_files!";
    #   x = "set viewmode!";
    #   i = "display_file";
    #   W = "display_log";
    #   w = "taskview_open";
    #   s = "shell $SHELL";
    #   r = "chain draw_possible_programs; console open_with%space";
    #   f = "console find%space";
    #   cd = "console cd%space";
    #   C-r = "reset";
    #   C-l = "redraw_window";
    #   C-c = "abort";
    #   esc = "change_mode normal";
    #   A-j = "scroll_preview 1";
    #   A-k = "scroll_preview -1";
    #   C-p = "chain console; eval fm.ui.console.history_move(-1)";
    #   CR = "move right=1";
    #   INSERT = "console touch%space";
    #   F1 = "help";
    #   F2 = "rename_append";
    #   F3 = "display_file";
    #   F5 = "copy";
    #   F6 = "cut";
    #   F8 = "console delete";
    #   F10 = "exit";
    #   UP = "move up=1";
    #   DOWN = "move down=1";
    #   LEFT = "move left=1";
    #   RIGHT = "move right=1";
    #   HOME = "move to=0";
    #   END = "move to=-1";
    #   PAGEDOWN = "move down=1 pages=True";
    #   PAGEUP = "move up=1 pages=True";
    #   DELETE = "console delete";

    #   gh = "cd ~";
    #   ge = "cd /etc";
    #   gu = "cd /usr";
    #   gd = "cd /dev";
    #   gl = "cd -r .";
    #   gL = "cd -r %f";
    #   go = "cd /opt";
    #   gv = "cd /var";
    #   gm = "cd /media";
    #   gi = "eval fm.cd('/run/media/' + os.getenv('USER'))";
    #   gM = "cd /mnt";
    #   gs = "cd /srv";
    #   gp = "cd /tmp";
    #   gr = "cd /";
    #   gR = "eval fm.cd(ranger.RANGERDIR)";
    #   "g/" = "cd /";
    #   "g?" = "cd /usr/share/doc/ranger";

    #   E = "edit";
    #   du = "shell -p du -d 1 -h \"$(2>/dev/null >&2 du --apparent-size /dev/null && printf '%s\n' --apparent-size || printf '%s\n' --)\"";
    #   dU = "shell -p du -d 1 -h \"$(2>/dev/null >&2 du --apparent-size /dev/null && printf '%s\n' --apparent-size || printf '%s\n' --)\" | sort -rh";
    #   yp = "yank path";
    #   yd = "yank dir";
    #   yn = "yank name";
    #   "y." = "yank name_without_extension";
    #   "=" = "chmod";
    #   cw = "console rename%space";
    #   a = "rename_append";
    #   A = "eval fm.open_console('rename ' + fm.thisfile.relative_path.replace(\"%\", \"%%\"))";
    #   I = "eval fm.open_console('rename ' + fm.thisfile.relative_path.replace(\"%\", \"%%\"), position=7)";
    #   pp = "paste";
    #   po = "paste overwrite=True";
    #   pP = "paste append=True";
    #   pO = "paste overwrite=True append=True";
    #   pl = "paste_symlink relative=False";
    #   pL = "paste_symlink relative=True";
    #   phl = "paste_hardlink";
    #   pht = "paste_hardlinked_subtree";
    #   pd = "console paste dest=";
    #   # p"<any>" = "paste dest=%any_path";
    #   # p'<any>' = "paste dest=%any_path";
    #   dD = "console delete";
    #   dT = "console trash";
    #   dd = "cut";
    #   ud = "uncut";
    #   da = "cut mode=add";
    #   dr = "cut mode=remove";
    #   dt = "cut mode=toggle";
    #   yy = "copy";
    #   uy = "uncut";
    #   ya = "copy mode=add";
    #   yr = "copy mode=remove";
    #   yt = "copy mode=toggle";
    #   dgg = "eval fm.cut(dirarg=dict(to=0), narg=quantifier)";
    #   dG = "eval fm.cut(dirarg=dict(to=-1), narg=quantifier)";
    #   dj = "eval fm.cut(dirarg=dict(down=1), narg=quantifier)";
    #   dk = "eval fm.cut(dirarg=dict(up=1), narg=quantifier)";
    #   ygg = "eval fm.copy(dirarg=dict(to=0), narg=quantifier)";
    #   yG = "eval fm.copy(dirarg=dict(to=-1), narg=quantifier)";
    #   yj = "eval fm.copy(dirarg=dict(down=1), narg=quantifier)";
    #   yk = "eval fm.copy(dirarg=dict(up=1), narg=quantifier)";
    #   "/" = "console search%space";
    #   n = "search_next";
    #   N = "search_next forward=False";
    #   ct = "search_next order=tag";
    #   cs = "search_next order=size";
    #   ci = "search_next order=mimetype";
    #   cc = "search_next order=ctime";
    #   cm = "search_next order=mtime";
    #   ca = "search_next order=atime";
    #   ot = "chain set sort=type;      set sort_reverse=True";
    #   oe = "chain set sort=extension; set sort_reverse=True";
    #   dc = "get_cumulative_size";
    #   zc = "set collapse_preview!";
    #   zd = "set sort_directories_first!";
    #   zh = "set show_hidden!";
    #   "zI" = "set flushinput!";
    #   zi = "set preview_images!";
    #   zm = "set mouse_enabled!";
    #   zp = "set preview_files!";
    #   zP = "set preview_directories!";
    #   zs = "set sort_case_insensitive!";
    #   zu = "set autoupdate_cumulative_size!";
    #   zv = "set use_preview_script!";
    #   zS = "set sort=size;      set sort_reverse=True";
    #   zB = "set sort=basename;  set sort_reverse=True";
    #   zN = "set sort=natural;   set sort_reverse=True";
    #   zM = "set sort=mtime;     set sort_reverse=True";
    #   zC = "set sort=ctime;     set sort_reverse=True";
    #   zA = "set sort=atime;     set sort_reverse=True";
    #   zT = "set sort=type;      set sort_reverse=True";
    #   zE = "set sort=extension; set sort_reverse=True";
    #   ".d" = "filter_stack add type d";
    #   ".f" = "filter_stack add type f";
    #   ".l" = "filter_stack add type l";
    #   ".m" = "console filter_stack add mime%space";
    #   ".n" = "console filter_stack add name%space";
    #   ".#" = "console filter_stack add hash%space";
    #   ".\"" = "filter_stack add duplicate";
    #   ".'" = "filter_stack add unique";
    #   ".|" = "filter_stack add or";
    #   ".&" = "filter_stack add and";
    #   ".!" = "filter_stack add not";
    #   ".r" = "filter_stack rotate";
    #   ".c" = "filter_stack clear";
    #   ".*" = "filter_stack decompose";
    #   ".p" = "filter_stack pop";
    #   ".." = "filter_stack show";
    #   "`<any>" = "enter_bookmark %any";
    #   "'<any>" = "enter_bookmark %any";
    #   "m<any>" = "set_bookmark %any";
    #   "um<any>" = "unset_bookmark %any";
    #   "br" = "console bulkrename";
    # };

  # aliases = {
  #   filter = ": scout -prts";
  #   hide = ": scout -prtsv";
  #   find = ": scout -aets";
  #   mark = ": scout -mr";
  #   unmark = ": scout -Mr";
  #   search = ": scout -rs";
  #   search_inc = ": scout -rts";
  #   travel = ": scout -aefklst";
  # };

    # settings = {
    #   # number = true;
    #   relativenumber = true;

    #   viewmode = "miller";
    #   column_ratios = [ 1 4 4 ];
    #   hidden_filter = "^\\.|.(?:pyc|pyo|bak|swp)$|^lost\\+found$|^__(py)?cache__$";
    #   show_hidden = true;
    #   confirm_on_delete = "never";
    #   use_preview_script = true;
    #   automatically_count_files = true;
    #   open_all_images = true;
    #   vcs_aware = false;
    #   vcs_backend_git = "enabled";
    #   vcs_backend_hg = "disabled";
    #   vcs_backend_bzr = "disabled";
    #   vcs_backend_svn = "disabled";
    #   vcs_msg_length = 50;
    #   preview_images = true;
    #   preview_images_method = "urxvt-full";
    #   iterm2_font_width = 8;
    #   iterm2_font_height = 11;
    #   unicode_ellipsis = false;
    #   bidi_support = false;
    #   show_hidden_bookmarks = true;
    #   colorscheme = "default";
    #   preview_files = true;
    #   preview_directories = true;
    #   collapse_preview = true;
    #   wrap_plaintext_previews = false;
    #   save_console_history = true;
    #   status_bar_on_top = false;
    #   draw_progress_bar_in_status_bar = true;
    #   draw_borders = "both";
    #   dirname_in_tabs = true;
    #   mouse_enabled = false;
    #   display_size_in_main_column = true;
    #   display_size_in_status_bar = true;
    #   display_free_space_in_status_bar = true;
    #   display_tags_in_all_columns = true;
    #   update_title = false;
    #   update_tmux_title = true;
    #   shorten_title = 3;
    #   hostname_in_titlebar = true;
    #   tilde_in_titlebar = true;
    #   max_history_size = 20;
    #   max_console_history_size = 50;
    #   scroll_offset = 8;
    #   flushinput = true;
    #   padding_right = true;
    #   autosave_bookmarks = true;
    #   save_backtick_bookmark = true;
    #   autoupdate_cumulative_size = true;
    #   show_cursor = false;
    #   sort = "natural";
    #   sort_reverse = false;
    #   sort_case_insensitive = true;
    #   sort_directories_first = true;
    #   sort_unicode = false;
    #   xterm_alt_key = false;
    #   cd_bookmarks = true;
    #   cd_tab_case = "smart";
    #   cd_tab_fuzzy = true;
    #   preview_max_size = 0;
    #   hint_collapse_threshold = 10;
    #   show_selection_in_titlebar = true;
    #   idle_delay = 100;
    #   metadata_deep_search = true;
    #   clear_filters_on_dir_change = false;
    #   line_numbers = "relative";
    #   relative_current_zero = false;
    #   one_indexed = true;
    #   save_tabs_on_exit = true;
    #   wrap_scroll = false;
    #   # global_inode_type_filter = null;
    #   freeze_files = false;
    #   size_in_bytes = false;
    #   nested_ranger_warning = true;
    # };
  };
}
