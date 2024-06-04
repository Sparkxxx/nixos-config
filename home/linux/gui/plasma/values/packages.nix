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
    kdePackages.kdenlive # Video editor
    kdePackages.zanshin # Getting Things Done application
    kdePackages.yakuake # Drop-down terminal emulator based on Konsole technologies
    kdePackages.umbrello # GUI for diagramming Unified Modelling Language (UML)
    kdePackages.tokodon # Tokodon is a Mastodon client for Plasma and Plasma Mobile
    kdePackages.kdeconnect-kde # Multi-platform app that allows your devices to communicate
  ];
}
