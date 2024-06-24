{
  config,
  pkgs,
  lib,
  ...
}: {
  # =========================================================================
  #      Services to be added on per HOST basis to NixOS Configuration
  # =========================================================================
  imports = [
    ## Docker daemon monitoring
    ../portainer.nix

    ## Local system NVR
    ../shinobi.nix

    ## llama and AI stack
    ../llmai

    ## Local system web support
    ../traefik/traefik.nix
    ../consul/consul-server.nix
    ../consul/consul-catalog.nix
  ];
}
