{config, ...}: {
  imports = [
    ./consul-base.nix
  ];

  services.consul = {
    extraConfig = {
      server = false;
    };
  };
}
