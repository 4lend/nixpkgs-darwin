# home/lf.nix
{ config, pkgs, lib, ... }:

let
  # ============================================================
  # 1. PREVIEWER SCRIPT (Pakai Ueberzug + Bat + Jq + Atool)
  # ============================================================
  previewerScript = pkgs.writeShellScript "lf-previewer" ''
    #!/bin/sh
    file="$1"
    width="$2"
    height="$3"
    
    mime=$(file --mime-type -b "$file")
    
    case "$mime" in
      inode/directory)
        ${pkgs.tree}/bin/tree -L 2 -C "$file" | head -n $height
        ;;
      text/*)
        ${pkgs.bat}/bin/bat --style=numbers --color=always "$file" 2>/dev/null || head -n $height "$file"
        ;;
      image/*|video/*)
        # Ueberzug untuk preview gambar/video
        ${pkgs.ueberzugpp}/bin/ueberzugpp -s "$file" -x $width -y $height 2>/dev/null || \
        ${pkgs.chafa}/bin/chafa --size="$width"x"$height" "$file" 2>/dev/null
        ;;
      application/pdf)
        # Preview PDF sebagai teks (fallback) + gambar dengan ueberzug
        ${pkgs.poppler}/bin/pdftotext -l 5 "$file" - 2>/dev/null | head -n $height || \
        ${pkgs.ueberzugpp}/bin/ueberzugpp -s "$file" -x $width -y $height 2>/dev/null
        ;;
      application/json)
        ${pkgs.jq}/bin/jq -C '.' "$file" 2>/dev/null | head -n $height
        ;;
      application/zip|application/x-tar|application/x-gzip)
        ${pkgs.atool}/bin/als -l "$file" 2>/dev/null | head -n $height
        ;;
      *)
        file -b "$file" | head -n $height
        ;;
    esac
  '';
  
  # ============================================================
  # 2. FILE ICONS (Lengkap)
  # ============================================================
  iconsFile = pkgs.writeText "lf-icons" ''
    ln 
    or 
    tw 
    ow 
    st 
    di 
    pi 
    so 
    bd 󰫱
    cd 󰫲
    su 
    sg 
    ex 
    fi 
    *.nix 
    *.json 
    *.toml 
    *.yaml 
    *.yml 
    *.md 
    *.sh 
    *.bash 
    *.zsh 
    *.fish 
    *.lua 
    *.go 
    *.js 
    *.ts 
    *.py 
    *.rs 
    *.html 
    *.css 
    *.scss 
    *.vue 
    *.c 
    *.cpp 
    *.java 
    *.rb 
    *.php 
    *.xml 
    *.sql 
    *.swift ﯣ
    *.kt 
    *.dart 
    *.tex 
    *.bib 
    .gitignore 
    .env 
    Dockerfile 
    Makefile 
    Cargo.toml 
    README 
    LICENSE 
    CHANGELOG 
    *.jpg 
    *.jpeg 
    *.png 
    *.gif 
    *.svg 
    *.webp 
    *.mp4 
    *.mkv 
    *.avi 
    *.mov 
    *.webm 
    *.mp3 
    *.flac 
    *.wav 
    *.ogg 
    *.pdf 
    *.zip 
    *.tar 
    *.gz 
    *.bz2 
    *.xz 
    *.7z 
    *.rar 
    *.doc 
    *.docx 
    *.xls 
    *.xlsx 
    *.ppt 
    *.pptx 
  '';
  
  # ============================================================
  # 3. FILE COLORS
  # ============================================================
  colorsFile = pkgs.writeText "lf-colors" ''
    di 01;34
    fi 00
    ln 01;36
    pi 01;33
    so 01;33
    bd 01;33
    cd 01;33
    or 01;31
    ex 01;32
    su 01;32
    sg 01;32
    tw 01;30
    ow 01;34
  '';
  
  # ============================================================
  # 4. SKRIP LFCD (Pindah Direktori Setelah Keluar LF)
  # ============================================================
  lfcdScript = pkgs.writeShellScript "lfcd" ''
    #!/bin/sh
    # Change directory to last dir in lf on exit
    cd "$(command lf -print-last-dir "$@")"
  '';
  
in
{
  # ============================================================
  # 5. KONFIGURASI LF
  # ============================================================
  programs.lf = {
    enable = true;
    
    settings = {
      ratios = [1 2 3];
      preview = true;
      dirpreviews = true;
      hidden = true;
      ignorecase = true;
      smartcase = true;
      wrap = false;
      number = true;
      relativenumber = true;
      scrolloff = 5;
      period = 1;
      dircounts = true;
      info = ["size"];
    };
    
    keybindings = {
      # ===== NAVIGASI =====
      "k" = "up";
      "j" = "down";
      "h" = "cd ..";
      "l" = "open";
      "gg" = "top";
      "G" = "bottom";
      "<C-u>" = "half-up";
      "<C-d>" = "half-down";
      
      # ===== FILE OPERATIONS =====
      "dd" = "delete";
      "yy" = "copy";
      "p" = "paste";
      "P" = "paste";
      "dD" = "delete";
      "dT" = "trash";
      "r" = "rename";
      
      # ===== MARKING / VISUAL MODE =====
      "v" = "toggle";
      "V" = "invert";
      "<Space>" = "toggle";
      
      # ===== SEARCH & FILTER =====
      "/" = "search";
      "n" = "search-next";
      "N" = "search-prev";
      "f" = "filter";
      
      # ===== SORTING =====
      "os" = "set sortby size";
      "ob" = "set sortby name";
      "on" = "set sortby name";
      "om" = "set sortby time";
      "ot" = "set sortby type";
      "or" = "set reverse!";
      
      # ===== QUICK PATHS =====
      "gh" = "cd ~";
      "ge" = "cd /etc";
      "gu" = "cd /usr";
      "gd" = "cd /dev";
      "gr" = "cd /";
      "gp" = "cd /tmp";
      
      # ===== TOGGLES =====
      "zh" = "set hidden!";
      "zp" = "set preview!";
      
      # ===== QUIT & REFRESH =====
      "q" = "quit";
      "R" = "reload";
      
      # ===== SHELL =====
      "s" = "$$SHELL";
      "!" = "$$SHELL";
      
      # ===== BOOKMARK =====
      "m" = "mark-save";
      "'" = "mark-load";
      
      # ===== OPEN WITH EDITOR =====
      "e" = "$$EDITOR $f";
      "E" = "$$EDITOR $f";
      
      # ===== INSPECT FILE =====
      "i" = "$file -b $f";
      
      # ===== CREATE FOLDER =====
      "<f7>" = ":push %mkdir ";
      
      # ===== CUSTOM FROM GITHUB CONFIG =====
      "w" = "$$TERMINAL -e $$SHELL -c 'cd $f; $$SHELL'";
      "W" = "$$TERMINAL -e $$SHELL -c 'cd $f; $$SHELL' &";
      "-" = "search";
      "f1" = ":push %{${pkgs.fzf}/bin/fzf --preview '${pkgs.bat}/bin/bat --style=numbers --color=always {}' | xargs -I {} lf -remote 'send $id select {}'}";
    };
    
    previewer = {
      source = previewerScript;
    };
    
    extraConfig = ''
      set icons
      set color256
      set number
      set relativenumber
      set scrolloff 5
      set period 1
    '';
  };
  
  # ============================================================
  # 6. TARUH FILE ICONS & COLORS
  # ============================================================
  xdg.configFile = {
    "lf/icons".source = iconsFile;
    "lf/colors".source = colorsFile;
  };
  
  # ============================================================
  # 7. LFCD - Pindah Direktori Setelah Keluar LF (Untuk Fish)
  # ============================================================
  programs.fish = {
    enable = true;
    functions = {
      lfcd = {
        body = ''
          cd "$(command lf -print-last-dir $argv)"
        '';
        description = "lf - Terminal file manager (changing directory on exit)";
        wraps = "lf";
      };
    };
    shellAbbrs = {
      lf = "lfcd";   # alias lf = lfcd
    };
  };
  
  # Juga untuk Bash dan Zsh (opsional)
  home.file = {
    ".local/bin/lfcd".source = lfcdScript;
  };
  
  # ============================================================
  # 8. DEPENDENCIES (Lengkap)
  # ============================================================
  home.packages = with pkgs; [
    tree
    bat
    chafa
    poppler
    jq
    atool
    file
    ueberzugpp     # Preview gambar/video/PDF (alternatif ueberzug untuk macOS)
    fzf            # Untuk fuzzy search
    trash-cli      # Untuk trash (dT)
    # ueberzug      # Pake ini jika di Linux X11
  ];
}
