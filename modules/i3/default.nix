{ pkgs, lib, ... }: { 

  services = { 
    displayManager = { 
      sddm.enable = false;

      defaultSession = "none+i3"; 
    };

    xserver = {
      enable = true;

      displayManager.lightdm = {
        enable = lib.mkDefault true;
        greeters.gtk.enable = true;
      };

      windowManager.i3 = {
        enable = true;
        configFile = ./config;
        extraPackages = with pkgs; [ 

          flameshot
          polybar polybarFull
          i3status
          i3-volume
          i3lock
          i3blocks
        ];
      };
    };

  };

}
