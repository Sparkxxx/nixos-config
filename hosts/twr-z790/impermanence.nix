{
  impermanence,
  pkgs,
  ...
}: {
  imports = [
    impermanence.nixosModules.impermanence
  ];

  environment.systemPackages = [
    # `sudo ncdu -x /`
    pkgs.ncdu
  ];

  # There are two ways to clear the root filesystem on every boot:
  ##  1. use tmpfs for /
  ##  2. (btrfs/zfs only)take a blank snapshot of the root filesystem and revert to it on every boot via:
  ##     boot.initrd.postDeviceCommands = ''
  ##       mkdir -p /run/mymount
  ##       mount -o subvol=/ /dev/disk/by-uuid/UUID /run/mymount
  ##       btrfs subvolume delete /run/mymount
  ##       btrfs subvolume snapshot / /run/mymount
  ##     '';
  #
  #  See also https://grahamc.com/blog/erase-your-darlings/

  # NOTE: impermanence only mounts the directory/file list below to /persistent
  # If the directory/file already exists in the root filesystem, you should
  # move those files/directories to /persistent first!
  environment.persistence."/persistent" = {
    # sets the mount option x-gvfs-hide on all the bind mounts
    # to hide them from the file manager
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
      "/etc/nix/inputs"
      "/etc/secureboot" # lanzaboote - secure boot
      # my secrets
      "/etc/agenix/"

      "/var/log"
      "/var/lib"

      # created by modules/nixos/misc/fhs-fonts.nix
      # for flatpak apps
      # "/usr/share/fonts"
      # "/usr/share/icons"
    ];
    files = [
      "/etc/machine-id"
    ];

    # the following directories will be passed to /persistent/home/$USER
    users.sparkx = {
      directories = [
        "codes"
        "nixos-config"
        "tmp"

        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "_work_"

        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }

        # keep all .config since plasma has files in it
        # it should be more locked down - TODO identify files for plasma
        ".config"

        # [sparkx@twr-z790:~/nixos-config]$ ls -al ../.config/
        # total 0
        # drwxr-xr-x  1 sparkx users 154 May  8 09:50  .
        # drwx------ 35 sparkx users 760 Jun  4 17:49  ..
        # drwxr-xr-x  1 sparkx users   8 May  8 09:50  Code
        # drwxr-xr-x  1 sparkx users   8 May  8 09:50 'Code - Insiders'
        # drwxr-xr-x  1 sparkx users   0 May  8 09:50  emacs
        # drwxr-xr-x  1 sparkx users   0 May  8 09:50  freerdp
        # drwxr-xr-x  1 sparkx users   0 May  8 09:50  github-copilot
        # drwxr-xr-x  1 sparkx users   0 May  8 09:50  google-chrome
        # drwxr-xr-x  1 sparkx users  22 May 23 08:45  nushell
        # drwxr-xr-x  1 sparkx users  12 Jun  3 11:55  pulse
        # drwxr-xr-x  1 sparkx users   0 May  8 09:50  remmina

        # [sparkx@twr-z790:~/nixos-config]$ ls -al ../.config/
        # total 36
        # drwxr-xr-x  1 sparkx users  368 Jun  4 18:01  .
        # drwx------ 35 sparkx users  760 Jun  4 17:49  ..
        # drwxr-xr-x  1 sparkx users  606 Jun  4 18:04  Code
        # drwxr-xr-x  1 sparkx users    8 May  8 09:50 'Code - Insiders'
        # drwx------  1 sparkx users    8 Jun  4 17:59  dconf
        # drwxr-xr-x  1 sparkx users    0 May  8 09:50  emacs
        # drwxr-xr-x  1 sparkx users    0 May  8 09:50  freerdp
        # drwxr-xr-x  1 sparkx users    0 May  8 09:50  github-copilot
        # drwxr-xr-x  1 sparkx users    0 May  8 09:50  google-chrome
        # drwx------  1 sparkx users    0 Jun  4 17:59  gtk-3.0
        # -rw-r--r--  1 sparkx users   51 Jun  4 17:58  gtkrc
        # -rw-r--r--  1 sparkx users   86 Jun  4 17:58  gtkrc-2.0
        # drwxr-xr-x  1 sparkx users  130 Jun  4 17:58  kdedefaults
        # -rw-------  1 sparkx users 3413 Jun  4 17:58  kdeglobals
        # -rw-------  1 sparkx users   38 Jun  4 17:58  konsolerc
        # -rw-r--r--  1 sparkx users 3429 Jun  4 18:01  kwinoutputconfig.json
        # drwxr-xr-x  1 sparkx users   22 May 23 08:45  nushell
        # drwxr-xr-x  1 sparkx users   12 Jun  3 11:55  pulse
        # drwxr-xr-x  1 sparkx users    0 May  8 09:50  remmina
        # -rw-------  1 sparkx users   55 Jun  4 17:58  systemsettingsrc
        # -rw-r--r--  1 sparkx users 1081 Jun  4 17:58  Trolltech.conf

        # misc
        ".config/pulse"
        ".pki"
        ".steam" # steam games

        # cloud native
        {
          # pulumi - infrastructure as code
          directory = ".pulumi";
          mode = "0700";
        }
        {
          directory = ".aws";
          mode = "0700";
        }
        {
          directory = ".docker";
          mode = "0700";
        }
        {
          directory = ".kube";
          mode = "0700";
        }

        # remote desktop
        ".config/remmina"
        ".config/freerdp"

        # doom-emacs
        ".config/emacs"
        "org" #  org files

        # vscode
        ".vscode"
        ".vscode-insiders"
        ".config/Code/User"
        ".config/Code - Insiders/User"

        # browsers
        ".mozilla"
        ".config/google-chrome"

        # neovim / remmina / flatpak / ...
        ".local/share"
        ".local/state"

        # language package managers
        ".npm"
        ".conda" # generated by `conda-shell`
        "go"

        # neovim plugins(wakatime & copilot)
        ".wakatime"
        ".config/github-copilot"
      ];
      files = [
        ".wakatime.cfg"
        ".config/nushell/history.txt"
      ];
    };
  };
}
