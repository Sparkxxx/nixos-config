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
    tor-browser

    # Email
    betterbird

    # Office
    libreoffice
    pdf2odt # PDF to ODT/ODS format converter
    pdfchain # graphical user interface for the PDF Toolkit
    pdf-sign # A tool to add signature visually inside PDF files
    pdfminer # tool for extracting information from PDF documents
    zathura # document viewer
    drawio

    # Video players
    smplayer
    vlc
    # kaffeine
    mpd
    #mpd-mpris
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly

    # e-book viewer(.epub/.mobi/...)
    foliate # do not support .pdf

    # instant messaging
    telegram-desktop
    discord
    skypeforlinux
    whatsapp-for-linux
    # teams-for-linux
    zoom-us
    #add matrix
    quasselClient

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
    gpa # Graphical user interface for the GnuPG
    #lorri # a nix-shell replacement for project development
    vorta # https://vorta.borgbase.com/

    ## tor network
    tor # Anonymizing overlay network
    torctl # Script to redirect all traffic through tor network including dns queries for anonymizing entire system
    nyx # Command-line monitor for Tor
    eschalot # Tor hidden service name generator
    # obfs4 # Circumvents censorship by transforming Tor traffic between clients and bridges

    sweethome3d.application # Design and visualize your future home
    sweethome3d.textures-editor # Easily create SH3T files and edit the properties of the texture images it contain
    sweethome3d.furniture-editor # Quickly create SH3F files and edit the properties of the 3D models it contain
  ];

  # GitHub CLI tool
  programs.gh = {
    enable = true;
  };

  # allow fontconfig to discover fonts and configurations installed through home.packages
  # Install fonts at system-level, not user-level
  fonts.fontconfig.enable = false;
}
