{ pkgs, config, ... }:

let
  username = "alfurqani";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  nixConfigDirectory = "${configHome}/nixpkgs";
in
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    shortcut = "a";
    resizeAmount = 10;
    # aggressiveAmount = true;
    terminal = "tmux-256color";  # "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      jump
      battery
      copycat
      vim-tmux-navigator
      vim-tmux-focus-events
      tmux-fzf
      tmux-thumbs
      yank
      cpu
      net-speed
      nord
      fpp
      cpu
      open
      { plugin = tilish;
      extraConfig = ''
        set -g @tilish-navigate 'on'
      '';
      }
      vim-tmux-navigator
      urlview
      sysstat
      sidebar
      copy-toolkit
      online-status
      prefix-highlight
      extrakto
      sensible
      resurrect
      online-status
    ];
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -g default-command  /run/current-system/sw/bin/fish
      set -g default-shell /run/current-system/sw/bin/fish
      set-option -g automatic-rename-format ""
      # set-option -g automatic-rename-format "#{window_index}"
      set-option -sa terminal-features ',XXX:RGB'

      set -s escape-time 0
      set -g base-index 1
      set -g @tilish-default 'main-horizontal'

      bind r source-file "${configHome}/tmux/tmux.conf" ; display "Reloaded!"

      unbind % 
      unbind '"' 
      unbind c 
      unbind n
      unbind p
      unbind l
      unbind C-l
                                                                               
      # window
      bind-key Space new-window
      bind-key b new-window 
      bind-key i split-window -h
      bind-key h split-window -v
      bind-key k kill-pane
      bind-key K kill-window
      bind-key - kill-pane

      # switch window
      bind-key n next-window
      bind-key p previous-window
      bind-key b last-window
                                                                               
      # bind -t vi-copy y copy-pipe 'xclip -in -selection clipboard'
                                                                               
      # resizing pane
      bind -r C-k resize-pane -U 5
      bind -r C-j resize-pane -D 5
      bind -r C-h resize-pane -L 5
      bind -r C-l resize-pane -R 5
                                                                               
      ## no prefix
      # switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
                                                                               
      # switch window
      bind -n M-p previous-window
      bind -n M-n next-window
      bind -n M-b last-window
                                                                               
      # yank
      bind -n M-] paste-buffer
      bind -n M-[ copy-mode

      bind -n C-k clear-history
    '';
  };
}
