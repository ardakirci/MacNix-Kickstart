 {
homebrew = {
    enable = true;

    brewPrefix = "/Users/arda/homebrew/bin";

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # `brew install`
    
        # `brew install --cask`
    
    casks = [
      "mongodb-compass"
      "wezterm"
            # "google-chrome"
    ];
  };
}
