{
  pkgs,
  lib,
  ...
}: {
  # =========================================================================
  #      Services to be added on per HOST basis to NixOS Configuration
  # =========================================================================
  imports = [
    ../portainer.nix
    ../shinobi.nix
    ../llmai
  ];
}
