{pkgs, ...}: {
  home.packages = with pkgs; [
    android-tools
    notepad-next
    # vscode is installed with home-manager in wayland.apps.nix - https://nixos.wiki/wiki/Visual_Studio_Code
    insomnia # API client for GraphQL, REST, WebSockets, SSE and gRPC. With Cloud, Local and Git storage. ~/.config/insomnia
    # httpie # https://httpie.io/ - FLOW THROUGH APIs desktop and cli
  ];
}
