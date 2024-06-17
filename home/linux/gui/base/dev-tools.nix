{pkgs, ...}: {
  home.packages = with pkgs; [
    android-tools
    notepad-next
    # vscode is installed with home-manager in wayland.apps.nix - https://nixos.wiki/wiki/Visual_Studio_Code
  ];
}
