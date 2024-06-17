{
  pkgs,
  config,
  lib,
  myvars,
  ...
}:
with lib; let
  cfgWayland = config.modules.desktop.wayland;
  #cfgXorg = config.modules.desktop.xorg;
in {
  imports = [
    ../base.nix
    ./base
    ./desktop
  ];

  options.modules.desktop = {
    wayland = {
      enable = mkEnableOption "Wayland displayServer";
    };
    # xorg = {
    #   enable = mkEnableOption "Xorg Display Server";
    # };
  };

  config = mkMerge [
    (mkIf cfgWayland.enable {
      # https://nixos.wiki/wiki/KDE
      services = {
        #Launch sddm in Wayland and avoid running an X server.
        xserver.enable = false; # running in wayland not xserver
        displayManager.defaultSession = "plasma";
        displayManager.sddm.enable = true;
        displayManager.sddm.wayland.enable = true;
        desktopManager.plasma6.enable = true;
      };
    })
  ];
}
