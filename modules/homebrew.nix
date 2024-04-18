{ pkgs, ...}: {

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  # 
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      # cleanup = "zap";
    };

    taps = [
      # "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      # "aria2"  # download tool
      "mariadb"
      # "mysql"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      ## Browser
      "firefox"
      # "brave-browser"
      "google-chrome"
      "opera"
      ## Downloader
      "free-download-manager"
      "xdm"
      ## Terminal
      "alacritty"
      "kitty"
      "wezterm"
      ## Chat
      "whatsapp"
      "telegram"
      ## Text Editor & Notes
      "visual-studio-code"
      "fleet"
      "sublime-text"
      "obsidian"
      "notion"
      ## Media
      "mpv"
      "digikam"
      "figma"
      "canva"
      ## Others
      "karabiner-elements"
      "mounty"
      # "dash"
      # "fbreader"
      "send-anywhere"
      "android-file-transfer"
      "google-drive"
      ## Failed Build
    ];
  };
}
