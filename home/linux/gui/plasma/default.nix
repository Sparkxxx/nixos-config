{
  pkgs,
  config,
  lib,
  ...
} @ args:
with lib; let
  cfg = config.modules.desktop.plasma;
in {
  imports = [
    #./options
  ];

  options.modules.desktop.plasma = {
    enable = mkEnableOption "plasma window manager";
  };

  config = mkIf cfg.enable (
    mkMerge (import ./values args)
  );
}
