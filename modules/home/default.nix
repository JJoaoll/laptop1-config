{ config, pkgs, inputs, system, ...}: {

  imports = [
    # ./keyboard
    ./programs
    ./shell
    # ./i3
  ];

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
  ];

  home = {
    username = "jjoaoll";
    homeDirectory = "/home/jjoaoll";
    stateVersion = "25.05";
  };
}
