{ pkgs, ... }: {

  imports = [
    ./audio.nix

  ];

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = haskellPackages: [
      haskellPackages.dbus
      haskellPackages.List
      haskellPackages.monad-logger
    ];

    # config = builtins.readFile ./xmonad.hs;
    
  };

  environment.systemPackages = with pkgs; [
    dmenu

  ];

  #example: 

  services.xserver.displayManager.sessionCommands = ''
    xset -dpms  # Disable Energy Star, as we are going to suspend anyway and it may hide "success" on that
    xset s blank # `noblank` may be useful for debugging 
    xset s 300 # seconds
    ${pkgs.lightlocker}/bin/light-locker --idle-hint &
  '';
  # services.xserver.windowManager.xmonad = {
  #   enable = true;
  #   enableContribAndExtras = true;
  #   flake = {
  #     enable = true;
  #     compiler = "ghc947";
  #   };
  #   config = builtins.readFile ./xmonad.hs;
  #   enableConfiguredRecompile = true;
  # };
}
