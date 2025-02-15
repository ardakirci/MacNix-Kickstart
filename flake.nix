{
  description = "Example Darwin system flake";

  inputs = {
    
    #nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    #darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # home
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # SFMono w/ patches
#    sf-mono-liga-src = {
#      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
#     flake = false;
#    };
    
    # icons
#    darwin-custom-icons.url = "github:ryanccn/nix-darwin-custom-icons";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager,... }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [

          # text editor
          helix
          cmake

          # terminal paketleri
          fzf
          gnupg
          tmux          
          fd
          ripgrep
          bat
          tree
          fastfetch
          gnutar

          # diller
          nil
          lldb
          cargo
          gdb
          taplo
          jdk
          luajitPackages.luarocks
          nodejs


          # LLM


        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;



      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;
      
      system.keyboard = {
        
        enableKeyMapping = true;
        # remapCapsLockToEscape = true;
      };
      # system.keyboard.remapCapsLockToControl = true;
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
      users.users."$USER" = {
        home = "/Users/$USER";
      };

    };
 in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .$YOUR_MAC
    darwinConfigurations."Ardas-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [
        configuration
        home-manager.darwinModules.home-manager  {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = false;
          home-manager.users.ardak = ./modules/home.nix;
        }
        ./modules/brew.nix
        ./fonts/sfmononerd.nix
        (import ./overlays)
        
        #darwin-custom-icons.darwinModules.default
        #(import ./icons)
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."$YOUR_MAC_NAME".pkgs;
  };
}
