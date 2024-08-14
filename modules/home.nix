
 {pkgs, ...}: {
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
      ];

/*      home.sessionVariables = {
        EDITOR = "nvim";
      }; */

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
          historySubstringSearch.enable = true;
          initExtra = builtins.readFile ./zshrc;

       };

        # p10k alternative prompt
        oh-my-posh = {
          enable = true;
          useTheme = "atomic";
          enableZshIntegration = true;
          settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./atomic.json));
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
 
