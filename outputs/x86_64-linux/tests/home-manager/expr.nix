{
  myvars,
  lib,
  outputs,
}: let
  username = myvars.username;
  hosts = [
    # "ai-hyprland"
    # "ai-i3"
    # "shoukei-hyprland"
    # "shoukei-i3"
    # "ruby"
    # "k3s-prod-1-master-1"
    "twr-z790-hyprland"
    "twr-z790-i3"
  ];
in
  lib.genAttrs
  hosts
  (
    name: outputs.nixosConfigurations.${name}.config.home-manager.users.${username}.home.homeDirectory
  )
