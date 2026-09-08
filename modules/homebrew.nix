{ system, pkgs, ... }: {

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae (and related files) not listed here.
      # cleanup = "zap";
    };

    taps = [
      "homebrew/services"
    ];

    # `brew install` (formulae)
    brews = [
      # "mariadb"   # uncomment kalau butuh
    ];

    # `brew install --cask`
    casks = [
      ## Browser
      "firefox"
      "brave-browser"
      "cloudflare-warp"

      ## Downloader
      "free-download-manager"
      "jdownloader"
      "hakuneko"
      "webtorrent"
      "qbittorrent"

      ## Terminal
      "alacritty"
      "kitty"
      "wezterm"
      
      ## Chat
      "whatsapp"
      "telegram"
      "discord"

      ## Text Editor & Notes
      "visual-studio-code"
      "notion"
      "notion-calendar"
      "obsidian"

      ## Media
      "digikam"
      "figma"
      "canva"
      "obs"

      ## Utilities & Lainnya
      "claude"
      "poe"
      "bitwarden"
      "karabiner-elements"
      "keyclu"
      "localsend"
      "mounty"
      "android-file-transfer"
      "menumeters"
      "flowvision"
      "todoist-app"
      "balenaetcher"
      "google-drive"
    ];
  };
}
