{ pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    kmonad
  ];

}
