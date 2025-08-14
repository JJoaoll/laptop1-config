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


  enviroment.systemPackages = with pkgs; [
    kmonad
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

  services.kmonad = {
    enable = true;
    keyboards.myKMonadKeyboard = {
      device = "/dev/input/by-path/pci-0000:07:00.3-usb-0:4:1.0-event-kbd";
      config = builtins.readFile ./layout.kbd;
    };
  };

  environment.sessionVariables = {
    XCOMPOSEFILE = "${config.users.users.${myUser}.home}/.XCompose";
  };

  system.activationScripts.copyXCompose = ''
    rm -f ${config.users.users.${myUser}.home}/.XCompose
    cp ${combinedXComposeFile} ${config.users.users.${myUser}.home}/.XCompose
    chown ${myUser}:${config.users.users.${myUser}.group} ${config.users.users.${myUser}.home}/.XCompose
  '';

  # NOTA IMPORTANTE:
  # A ativação da tecla Compose (ex: Right Alt) deve ser feita
  # na configuração do seu compositor Wayland (Sway, Hyprland, GNOME, etc.).
  #
  # Exemplo para Sway/Hyprland (via home-manager):
  # wayland.windowManager.sway.input."type:keyboard".xkb.options = [ "compose:ralt" ];
  #
  # Para GNOME/KDE, use as configurações de teclado da interface gráfica.

}
