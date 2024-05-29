{pkgs, ...}: {
  home.packages = with pkgs; [
    # db related
    dbeaver-bin

    mitmproxy # http/https proxy tool
    insomnia # REST client
    wireshark # network analyzer
  ];
}
