{ inputs, ... }: 


{

  imports = [ inputs.nvf.nixosModules.default ];


  programs.nvf = {
    enable = true;
    
    # Your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        options = {
          tabstop = 2;
          shiftwidth = 2;
        };


        
        statusline.lualine = {
          enable = true;
          theme = "gruvbox_dark";
        };

        lsp = {
          enable = true;
        };

        languages = {
          enableDAP = true;
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableTreesitter = true;

          nix.enable = true; 
          haskell.enable = true;
        }; 
      };
    };
  };

}

