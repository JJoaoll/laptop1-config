{ config, pkgs, lib, ... }:

let
  myUser = "jjoaoll";
  unicodeComposeFiles = [
    ./.unicodef/emoji.XCompose
    ./.unicodef/fonts.XCompose
    ./.unicodef/games.XCompose
    ./.unicodef/greek.XCompose
    ./.unicodef/lang.XCompose
    ./.unicodef/math.XCompose
    ./.unicodef/misc.XCompose
    ./.unicodef/thatex.XCompose
  ];

  combinedUnicodeComposeContent = lib.concatStringsSep "\n" (
    lib.map builtins.readFile unicodeComposeFiles
  );

  baseXComposeContent = ''
    include "%L"
  '';

  finalXComposeContent = "${baseXComposeContent}\n${combinedUnicodeComposeContent}";

  combinedXComposeFile = pkgs.writeText "my-combined-xcompose" finalXComposeContent;

in {

  #TODO: move another things to there:
  services.xserver.xkb = {
    options = "compose:ralt";  
  };

  environment.systemPackages = with pkgs; [
    kmonad
  ];

  services.kmonad = {
    enable = true;
    keyboards.myKMonadKeyboard = {
      device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
      config = builtins.readFile ./layout.kbd;
    };
  };

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "x11";
    XCOMPOSEFILE = "${config.users.users.${myUser}.home}/.XCompose";
  };

  system.activationScripts.copyXCompose = ''
    rm -rf ${config.users.users.${myUser}.home}/.unicodef
    rm -f ${config.users.users.${myUser}.home}/.XCompose

    cp ${combinedXComposeFile} ${config.users.users.${myUser}.home}/.XCompose

    chown -R ${myUser}:${config.users.users.${myUser}.group} ${config.users.users.${myUser}.home}/.XCompose
  '';

  # system.activationScripts.copyXCompose = ''
  #   rm -f ${config.users.users.${myUser}.home}/.XCompose
  #   cp ${combinedXComposeFile} ${config.users.users.${myUser}.home}/.XCompose
  #   chown ${myUser}:${config.users.users.${myUser}.group} ${config.users.users.${myUser}.home}/.XCompose
  # '';


}
