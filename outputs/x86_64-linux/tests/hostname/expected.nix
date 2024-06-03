{
  lib,
  outputs,
}: let
  specialExpected = {
    # "ai-hyprland" = "ai";
    # "ai-i3" = "ai";
    # "shoukei-hyprland" = "shoukei";
    # "shoukei-i3" = "shoukei";

    "twr-z790-hyprland" = "twr-z790";
    "twr-z790-i3" = "twr-z790";
    "twr-z790-plasma" = "twr-z790";
  };
  specialHostNames = builtins.attrNames specialExpected;

  otherHosts = builtins.removeAttrs outputs.nixosConfigurations specialHostNames;
  otherHostsNames = builtins.attrNames otherHosts;
  # other hosts's hostName is the same as the nixosConfigurations name
  otherExpected = lib.genAttrs otherHostsNames (name: name);
in (specialExpected // otherExpected)
