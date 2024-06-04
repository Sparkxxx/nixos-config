{pkgs, ...}: {
  home.packages = with pkgs; [
    android-tools
    notepad-next
    vscode
  ];
}
