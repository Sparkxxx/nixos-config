{mylib, ...}: {
  imports = mylib.scanPaths ./.;
  # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/services/x11/desktop-managers/plasma5.nix#L275-L284
}
