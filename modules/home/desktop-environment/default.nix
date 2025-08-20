{ pkgs, ... }: {

  imports = [
    ./picom.nix
    ./rofi.nix
  ];

  home.packages = with pkgs; [
    nitrogen 
  ];

}
