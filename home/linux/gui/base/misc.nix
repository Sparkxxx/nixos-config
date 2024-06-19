{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    # GUI apps

    # Browsers
    firefox
    brave
    ungoogled-chromium

    # Email
    betterbird

    # Video players
    smplayer
    vlc
    # kaffeine
    mpd
    #mpd-mpris

    # e-book viewer(.epub/.mobi/...)
    foliate # do not support .pdf

    # instant messaging
    telegram-desktop
    discord
    skypeforlinux
    whatsapp-for-linux
    # teams-for-linux

    # remote desktop(rdp connect)
    remmina
    freerdp # required by remmina
    anydesk

    # misc
    flameshot
    ventoy # cli multi-boot usb creator
    krusader # Twin panel file management

    ## mine
    intel-compute-runtime
    clinfo
    aha
    wayland-utils
  ];

  # GitHub CLI tool
  programs.gh = {
    enable = true;
  };

  # allow fontconfig to discover fonts and configurations installed through home.packages
  # Install fonts at system-level, not user-level
  fonts.fontconfig.enable = false;
}
