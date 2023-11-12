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
      "homebrew/cask"
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
      "sublime-text"
      "brave-browser"
      "disk-drill"
      "free-download-manager"
      "kitty"
      "mounty"
      "mpv"
      "obsidian"
      "xdm"
      "google-chrome"
      "dash"
      # "fbreader"
      "send-anywhere"
      "alacritty"
      "google-drive"
    ];
  };
}
