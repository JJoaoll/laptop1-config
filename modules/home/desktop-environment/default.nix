{ pkgs, ... }: {

  imports = [
    ./polybar
    ./picom.nix
    ./rofi.nix
  ];

  home.packages = with pkgs; [
    nitrogen 
  ];

}
