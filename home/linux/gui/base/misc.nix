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
 
    # Video players
    smplayer
    vlc
    # kaffeine
    # mpv and mpv-mpris
    
    # e-book viewer(.epub/.mobi/...)
    foliate # do not support .pdf

    # instant messaging
    telegram-desktop
    discord
    skypeforlinux
    whatsapp-for-linux
    #pkgs-unstable.qq # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/networking/instant-messengers/qq

    # Email 
    betterbird

    # remote desktop(rdp connect)
    remmina
    freerdp # required by remmina
    anydesk

    # misc
    flameshot
    ventoy # cli multi-boot usb creator

  ];

  # GitHub CLI tool
  programs.gh = {
    enable = true;
  };

  # allow fontconfig to discover fonts and configurations installed through home.packages
  # Install fonts at system-level, not user-level
  fonts.fontconfig.enable = false;
}
