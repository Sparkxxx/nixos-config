{
  config,
  lib,
  pkgs,
  ...
}: {
  # To use VS Code under Wayland, set the environment variable NIXOS_OZONE_WL=1:
  environment = {
    sessionVariables = {
      #LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
      NIXOS_OZONE_WL = "1";
    };
  };

  # add user's shell into /etc/shells
  environment.shells = with pkgs; [
    bashInteractive
    nushell
  ];

  # set user's default shell system-wide
  users.defaultUserShell = pkgs.bashInteractive;

  # fix for `sudo xxx` in kitty/wezterm and other modern terminal emulators
  security.sudo.keepTerminfo = true;

  environment.variables = {
    # fix https://github.com/NixOS/nixpkgs/issues/238025
    TZ = "${config.time.timeZone}";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gnumake
  ];

  ## GNOME specific
  # services = {
  #   gvfs.enable = true; # Mount, trash, and other functionalities
  #   tumbler.enable = true; # Thumbnail support for images
  # };

  programs = {
    # The OpenSSH agent remembers private keys for you
    # so that you don’t have to type in passphrases every time you make an SSH connection.
    # Use `ssh-add` to add a key to the agent.
    ssh.startAgent = true;

    # dconf is a low-level configuration system.
    dconf.enable = true;

    # Could not detect a default hypervisor. Make sure the appropriate QEMU/KVM virtualization packages are installed to manage virtualization on this host.
    # A virtualization connection can be manually added via File->Add Connection or like this, check the page https://nixos.wiki/wiki/Virt-manager
    # https://github.com/nix-community/home-manager/issues/2106#issuecomment-1479114851 - It would be nice to have a note in the docs for dconf.settings mentioning that this option is known to not work -- I just spent a while trying to figure out what I was doing wrong before I found this issue.
    #     dconf.settings = {
    #       "org/virt-manager/virt-manager/connections" = {
    #         autoconnect = ["qemu:///system"];
    #         uris = ["qemu:///system"];
    #       };
    #     };

    # thunar file manager(part of xfce) related options
    # thunar = {
    #   enable = true;
    #   plugins = with pkgs.xfce; [
    #     thunar-archive-plugin
    #     thunar-volman
    #   ];
    # };
  };
}
