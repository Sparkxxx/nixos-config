{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.plasma;
in {
  options.modules.desktop.plasma = {
    nvidia = mkEnableOption "whether nvidia GPU is used";
  };

  config = mkIf (cfg.enable && cfg.nvidia) {
    # wayland.windowManager.plasma.settings.env = [
    #   # for plasma with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
    #   "LIBVA_DRIVER_NAME,nvidia"
    #   "XDG_SESSION_TYPE,wayland"
    #   "GBM_BACKEND,nvidia-drm"
    #   "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    #   # fix https://github.com/hyprwm/Hyprland/issues/1520
    #   "WLR_NO_HARDWARE_CURSORS,1"
    # ];
  };
}
