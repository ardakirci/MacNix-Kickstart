
 {pkgs, config, ...}: {
      # this is internal compatibility configuration 
      # for home-manager, don't change this!
      home.stateVersion = "24.05";
      # Let home-manager install and manage itself.
      programs.home-manager.enable = true;


      # packages that I manage with home manager is installed through here
      home.packages = with pkgs; [
        zoxide
        oh-my-posh
        lsd
        yazi
#        zsh-powerlevel10k
#        gitstatus
        #python3

        (python3.withPackages (python-pkgs: with python-pkgs; [
          # select Python packages here
          python-lsp-server
         ]))

      ];

/*      home.sessionVariables = {
        EDITOR = "nvim";
      }; */

      
      home.file = {
        ".config/helix" = {
          source = config.lib.file.mkOutOfStoreSymlink "/Users/ardak/nix/dotfiles/helix";
          recursive = true;
        };
        ".config/wezterm" = {
          source = config.lib.file.mkOutOfStoreSymlink "/Users/ardak/nix/dotfiles/wezterm";
          recursive = true;
        };
        ".config/aerospace" = {
          source = config.lib.file.mkOutOfStoreSymlink "/Users/ardak/nix/dotfiles/aerospace";
          recursive = true;
        };
      };

      programs = {
        
        # modern vim
        neovim = {
          enable = true;
          defaultEditor = true;
          vimAlias = true;
        };

        # modern cd
        zoxide = {
          enable = true;
          enableZshIntegration = true;
          options = 
          [
            "--cmd cd"
          ];
        };

        zsh = {
          enable = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;

          #plugins = [
           # { name = "powerlevel10k";
            #  src = pkgs.zsh-powerlevel10k;
             # file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";}
          #];

          initExtra = builtins.readFile ./zshrc;

       };

        # p10k alternative prompt
        oh-my-posh = {
          enable = true;
#          useTheme = "atomic";
          enableZshIntegration = true;
          settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./catppuccin.json));
        };

        # terminal file manager
        yazi = {
          enable = true;
          enableZshIntegration = true;
        };

        # modern ls
        lsd = {
          enable = true;
          enableAliases = true;
        };


/*
        eza = {
          enable = true;
          enableZshIntegration = true;
          git = true;
          icons = true;
        };
*/

      };
    }
 
