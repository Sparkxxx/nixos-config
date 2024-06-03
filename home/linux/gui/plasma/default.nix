{
  pkgs,
  config,
  lib,
  #anyrun,
  ...
} @ args:
with lib; let
  cfg = config.modules.desktop.plasma;
in {
  imports = [
    # anyrun.homeManagerModules.default
    ./options
  ];

  options.modules.desktop.plasma = {
    enable = mkEnableOption "plasma compositor";
    settings = lib.mkOption {
      type = with lib.types; let
        valueType =
          nullOr (oneOf [
            bool
            int
            float
            str
            path
            (attrsOf valueType)
            (listOf valueType)
          ])
          // {
            description = "plasma configuration value";
          };
      in
        valueType;
      default = {};
    };
  };

  # config = mkIf cfg.enable (
  #   # mkMerge ([
  #   #     {
  #   #       wayland.windowManager.plasma.settings = cfg.settings;
  #   #     }
  #   #   ]
  #   #   ++ (import ./values args))
  # );
}
