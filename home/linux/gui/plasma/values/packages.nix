{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    # waybar # the status bar
    # swaybg # the wallpaper
    # swayidle # the idle timeout
    # swaylock # locking the screen
    # wlogout # logout menu
    # wl-clipboard # copying and pasting
    # hyprpicker # color picker

    # pkgs-unstable.hyprshot # screen shot
    # grim # taking screenshots
    # slurp # selecting a region to screenshot
    # wf-recorder # screen recording

    # mako # the notification daemon, the same as dunst

    # yad # a fork of zenity, for creating dialogs

    # # audio
    # alsa-utils # provides amixer/alsamixer/...
    # mpd # for playing system sounds
    # mpc-cli # command-line mpd client
    # ncmpcpp # a mpd client with a UI
    # networkmanagerapplet # provide GUI app: nm-connection-editor

    # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/services/x11/desktop-managers/plasma5.nix#L275-L284
    kdePackages.kdenlive # Video editor
    glaxnimate # Simple vector animation program.- required by kdenlive
    kdePackages.spectacle # Screen recorder
    kdePackages.zanshin # Getting Things Done application
    kdePackages.yakuake # Drop-down terminal emulator based on Konsole technologies
    #kdePackages.umbrello # GUI for diagramming Unified Modelling Language (UML) - 24.05.0 is broken
    kdePackages.tokodon # Tokodon is a Mastodon client for Plasma and Plasma Mobile
    kdePackages.neochat # A client for matrix, the decentralized communication protocol
    kdePackages.kdeconnect-kde # Multi-platform app that allows your devices to communicate
    kdePackages.kmail # State-of-the-art feature-rich email client that supports many protocols
    kdePackages.kmail-account-wizard # Application which assists you with the configuration of accounts in KMail
    kdePackages.kdepim-addons # Add-ons for KDE PIM apps (KMail, KAddressBook etc.)
    kdePackages.kmailtransport # Library, KCM and KDED module to manage mail transport
    kdePackages.ktorrent
    kdePackages.partitionmanager
    kdePackages.polkit-kde-agent-1
    kdePackages.sddm-kcm # Configuration module for SDDM
    kdePackages.kgamma # Adjust your monitor's gamma settings
    kdePackages.kgpg # Simple interface for GnuPG, a powerful encryption utility
    kdePackages.kget # Download Manager
    kdePackages.kwallet # KWallet: Credential Storage
    kdePackages.kjournald # Framework for interacting with systemd-journald

    kdePackages.kalk # Kalk is a powerful cross-platform calculator application built with the [Kirigami framework](https://kde.org/products/kirigami/)
    kdePackages.kcalc # Calculator offering everything a scientific calculator does, and more
    kdePackages.kbruch # Practice Fractions
    kdePackages.ksirk # KsirK is a computerized version of a well known strategy game
    kdePackages.kmines # KMines is the classic Minesweeper game
    kdePackages.ksudoku # KSudoku is a logic-based symbol placement puzzle
    kdePackages.knights # Chess board program.
    kdePackages.katomic # Katomic is a fun and educational game built around molecular geometry
    kdePackages.kalzium #Periodic Table of Elements
    kdePackages.blinken # Memory Enhancement Game
    kdePackages.khangman # A hangman game
    kdePackages.granatier # Granatier is a clone of the classic Bomberman game

    kdePackages.audiotube # Client for YouTube Music
    kdePackages.plasmatube # Kirigami YouTube video player based on QtMultimedia and youtube-dl
    kdePackages.ksystemlog # KDE SystemLog Application
    kdePackages.plasma-disks # Monitors S.M.A.R.T. capable devices for imminent failure.
    kdePackages.ksystemstats # A plugin based system monitoring daemon.
    kdePackages.isoimagewriter # Program to write hybrid ISO files onto USB disks
    kdePackages.qtspeech # Cross-platform application framework for C++

    kdePackages.alpaka # Kirigami client for Ollama
    kdePackages.full
    kdePackages.kio # Network transparent access to files and data
    kdePackages.kio-admin # Manage files as administrator using the admin:// KIO protocol.
    kdePackages.kpat # KPatience offers a selection of solitaire card games
    kdePackages.koko # Image gallery application
    kdePackages.tokodon # Tokodon is a Mastodon client for Plasma and Plasma Mobile
    kdePackages.neochat # A client for matrix, the decentralized communication protocol
    kdePackages.sweeper # Application that helps to clean unwanted traces the user leaves on the system
    kdePackages.kalm # Kalm can teach you different breathing techniques.
  ];
}
