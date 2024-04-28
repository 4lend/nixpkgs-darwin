{ pkgs, config, ... }:

let
  fishConfig = ''
    bind \t accept-autosuggestion
    # bind X forward-word
    set -U fish_greeting

    bind \co 'tig'

    colorscript exec colortest
  '';

  # colortest, colorwheel, blocks

  shellAliases = {
    l = "exa -1 -g -l --icons -s type";
    la = "exa -1 -g -l --icons -s type -a";
    lt = "exa -1 -g -l --icons -s type -T";
    lat = "exa -1 -g -l --icons -s type -a -T";
    du = "${pkgs.du-dust}/bin/dust";
    git = "${pkgs.git}/bin/git";
    grep = "${pkgs.ripgrep}/bin/rg";

    nb = "nix build";
    nbs = "sudo nixos-rebuild switch --flake .#alfurqani";
    nbsi = "sudo nixos-rebuild switch --flake .#alfurqani --impure";
    nbb = "sudo nixos-rebuild build --flake .#alfurqani";
    nbbi = "sudo nixos-rebuild build --flake .#alfurqani --impure";
    nbr = "sudo nixos-rebuild build --flake .#alfurqani && sudo ./result/activate";
    nbri = "sudo nixos-rebuild build --flake .#alfurqani --impure && sudo ./result/activate";
    nbt = "sudo nixos-rebuild test --flake .#alfurqani";
    nbti = "sudo nixos-rebuild test --flake .#alfurqani --impure";
    nbo = "sudo nixos-rebuild boot --flake .#alfurqani";
    nboi = "sudo nixos-rebuild boot --flake .#alfurqani --impure";
    ns = "nix-shell";
    nsp = "nix-shell -p";
    nclean = "nix-collect-garbage; nix-collect-garbage -d";
    nopt = "nix store optimise";
    conix = "sudo nvim /etc/nixos/configuration.nix";
    nc = "nix-channel";
    ncl = "nix-channel --list";
    nca = "nix-channel --add";
    ncrm = "nix-channel --remove";
    ncu = "nix-channel --update";
    # hb        = "home-manager build";
    # hs        = "home-manager switch";
    # hg        = "home-manager generations";
    nf = "nix flake";
    nfu = "nix flake update";
    nfa = "nix flake archive";
    nfs = "nix flake show";
    nfi = "nix flake info";
    nfc = "nix flake check";
    homehelp = "man home-configuration.nix";
    confhelp = "man configuration.nix";
    ngit = "nix-prefetch-url --unpack";

    tls = "tmux list-sessions";
    tkls = "tmux kill-session";
    kat = "pkill -f tmux";
    tks = "tmux kill-server";
    tat = "tmux attach";
    ts = "tmux sessions";

    g = "git";
    gs = "git status";
    ge = "git clone";
    gcg = "git config --global";
    gc = "git config";
    gcl = "git config --list";
    gcgl = "git config --global --list";
    ga = "git add";
    gal = "git add -A";
    gcm = "git commit -m";
    gam = "git commit -a -m";
    gsi = "git switch";
    gco = "git checkout";
    gr = "git remote";
    gra = "git remote add";
    grmv = "git remote remove";
    grv = "git remote -v";
    gb = "git branch";
    gbl = "git branch --list";
    gp = "git push";
    gpu = "git push --set-upstream";
    gl = "git log";
    glg = "git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches";
    gd = "git diff";
    grs = "git reset";
    grss = "git reset --soft";
    grsh = "git reset --hard";
    gpl = "git pull";

    gq = "ghq";
    gqg = "ghq get";
    gql = "ghq list";

    y = "yt-dlp";
    yp = "yt-dlp --proxy 192.168.49.1:8000";
    yy = "yt-dlp --ignore-config --extract-audio --audio-quality 0";
    yyp = "yt-dlp --ignore-config --extract-audio --audio-quality 0 --proxy 192.168.49.1:8000";
    c = "cd";
    d = "cd ..";
    v = "vim";
    nv = "nvim";
    nvv = "nvim .";
    vd = "neovide";
    p = "py *.py";
    t = "tmux";
    e = "exit";
    lv = "lvim";
    sp = "speedtest-cli";
    py = "python";
    py3 = "python3";
    ph = "php";
    b = "bat";
    B = "cat";
    cl = "clear";
    s = "sudo su";
    sd = "sudo";
    mkd = "mkdir";
    toh = "touch";
    cpr = "cp -r";
    rm = "rm";
    rmf = "rm -rf";
    a = "aria2c";
    vf = "vifm";
    ra = "ranger";
    pc = "protonvpn-cli";
    nq = "notepadqq";
    bs = "bash";
    whi = "which";
    whe = "whereis";
    sn = "sncli";
    tdl = "todoist";
    gdo = "gdown";
    df = "duf";

    ud = "udisksctl";
    udm = "udisksctl mount -b";
    udmd = "udisksctl unmount -b";

    sysr = "systemctl reboot";
    syss = "systemctl suspend";
    sysp = "systemctl poweroff";
    sysd = "systemctl daemon-reload";
  };
in
{
  programs = {
    fish = {
      enable = true;
      shellAliases = shellAliases;
      shellInit = fishConfig;
      interactiveShellInit = ''
        ${pkgs.thefuck}/bin/thefuck --alias | source
        # Fish color
        set -U fish_color_command 6CB6EB --bold
        set -U fish_color_redirection DEB974
        set -U fish_color_operator DEB974
        set -U fish_color_end C071D8 --bold
        set -U fish_color_error EC7279 --bold
        set -U fish_color_param 6CB6EB
        set fish_greeting
      '';
    };
    nushell = {
      enable = true;
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      # enableSyntaxHighlighting = true; 
      historySubstringSearch.enable = true;
      shellAliases = shellAliases;
    };
    bash = {
      enable = true;
    };
    autojump = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        command_timeout = 1000;
        cmd_duration = {
          format = " [$duration]($style) ";
          style = "bold #EC7279";
          show_notifications = true;
        };
        nix_shell = {
          format = " [$symbol$state]($style) ";
        };
        battery = {
          full_symbol = "🔋 ";
          charging_symbol = "⚡️ ";
          discharging_symbol = "💀 ";
        };
        git_branch = {
          format = "[$symbol$branch]($style) ";
        };
        gcloud = {
          format = "[$symbol$active]($style) ";
        };
      };
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
