 {
homebrew = {
    enable = true;

    brewPrefix = "/Users/ardak/homebrew/bin";

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # `brew install`
/*    brews = [
      "llvm"
    ]; */
        # `brew install --cask`
    taps = [
      "nikitabobko/aerospace"
    ];


    casks = [
      "whatsapp"
      "iterm2@nightly"
      "firefox"
      "spotify"
      "qbittorrent"
      "coconutbattery"
      "mullvadvpn"
#     "wezterm"
      "wezterm@nightly"
      "visual-studio-code"
      "zed"
      "gitkraken"
      "clion"
      "tor-browser"
      "arc"
      "chromium"
      "via"
      "qmk-toolbox"
      "steam"
      "discord"
      "zoom"
      "kitty"
      "emacs"
      "aerospace"
      "orion"
    ];
/*
    masApps =  {
 #     Xcode = 497799835;
      "Focus for YouTube" = 1514703160;
      "AdGuard for Safari" = 1440147259;
      "Microsoft Word" = 462054704;
      "Microsoft PowerPoint" = 462062816;
      "Microsoft Excel" = 462058435;
      Keynote = 409183694;
      Numbers = 409203825;
      Pages = 409201541;
    }; */
  };
}
