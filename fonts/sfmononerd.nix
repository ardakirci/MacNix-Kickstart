{pkgs, ...}: {
  packages = {
    fontDir.enable = true;
    fonts = with pkgs; [ 
      sf-mono-liga-bin
      (nerdfonts.override { fonts = [ "Hack" ]; }) 
    ];
  };
}
