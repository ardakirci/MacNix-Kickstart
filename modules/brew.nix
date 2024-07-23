 {
homebrew = {
    enable = true;

    brewPrefix = "/Users/arda/nix/brewlib/homebrew/bin";

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # `brew install`

        # `brew install --cask`

    casks = [
      "firefox"
      "spotify"
      "qbittorrent"
      "coconutbattery"
      "mullvadvpn"
      "wezterm"
      "visual-studio-code"
      "zed"
      "gitkraken"
      "clion"
      "tor-browser"
      "arc"
      "chromium"
      "via"
      

    ];
  };
}
