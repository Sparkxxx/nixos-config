{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./consul-base.nix
  ];

  services.consul = {
    interface.bind = "enp3s0";
    extraConfig = {
      server = true;
      bootstrap_expect = 1;
    };
  };
}
