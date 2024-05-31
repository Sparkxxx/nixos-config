{
  pkgs,
  lib,
  plasma,
  #nur-ryan4yin,
  ...
}: let
  package = plasma.packages.${pkgs.system}.plasma;
in {

wayland.windowManager.plasma = {
    inherit package;
    enable = true;
    # settings = {
    #   source = "${nur-ryan4yin.packages.${pkgs.system}.catppuccin-hyprland}/themes/mocha.conf";
    #   env = [
    #     "NIXOS_OZONE_WL,1" # for any ozone-based browser & electron apps to run on wayland
    #     "MOZ_ENABLE_WAYLAND,1" # for firefox to run on wayland
    #     "MOZ_WEBRENDER,1"
    #     # misc
    #     "_JAVA_AWT_WM_NONREPARENTING,1"
    #     "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    #     "QT_QPA_PLATFORM,wayland"
    #     "SDL_VIDEODRIVER,wayland"
    #     "GDK_BACKEND,wayland"
    #   ];
    # };
    # extraConfig = builtins.readFile ../conf/hyprland.conf;
    # # gammastep/wallpaper-switcher need this to be enabled.
    systemd.enable = true;
  };
}
