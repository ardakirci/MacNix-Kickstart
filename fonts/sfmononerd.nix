{pkgs, ...}: {
  fonts = {
    # fontDir.enable = true;
    packages = with pkgs; [ 
      sf-mono-liga-bin
    ];
  };
}
