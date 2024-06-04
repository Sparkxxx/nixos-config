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
    ./base
    ../base.nix

    ./desktop
  ];

  options.modules.desktop = {
    wayland = {
      enable = mkEnableOption "Wayland Display Server";
    };
    # xorg = {
    #   enable = mkEnableOption "Xorg Display Server";
    # };
  };

  config = mkMerge [
    (mkIf cfgWayland.enable {
      ####################################################################
      #  NixOS's Configuration for Wayland based Window Manager
      ####################################################################
      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
        ];
      };

      services = {
        xserver.enable = true; # disable xorg server
        xserver.displayManager.defaultSession = "plasma";
        displayManager.sddm.enable = true;
        #displayManager.sddm.wayland.enable = true;
        desktopManager.plasma6.enable = true;
        
      };
    })
  ];
}
