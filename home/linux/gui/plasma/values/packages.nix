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
  ];
}
