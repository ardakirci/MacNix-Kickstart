{
  description = "Example Darwin system flake";

  inputs = {
    #nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    #darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

       # SFMono w/ patches
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
    # icons
    # darwin-custom-icons.url = "github:ryanccn/nix-darwin-custom-icons";

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, ... }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [
          # text editor
          vim
          neovim
          helix
          cmake
          emacs
          # terminal paketleri
          neofetch
          eza
          fzf
          gnupg
          tmux          
          zoxide
          fd
          ripgrep
          bat
          tree          
          # diller
          lldb
          cargo


          jdk
          luajitPackages.luarocks

        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";
      nixpkgs.config.allowUnfree = true;

      # Sudo touchID enable
      security.pam.enableSudoTouchIdAuth = true;


     };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Ardas-MacBook-Pro
    darwinConfigurations."Ardas-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [
        configuration
        ./modules/brew.nix
        ./fonts/sfmononerd.nix
        (import ./overlays)

        #iconlar bozuk
        #darwin-custom-icons.darwinModules.default
        #(import ./icons)
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Ardas-MacBook-Pro".pkgs;
  };
}
