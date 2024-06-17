{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    source-code-pro #used by kmscon
    neofetch
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.

    # # System tools
    # git
    # wget
    # gnumake
    # clinfo
    # vulkan-tools
    # glxinfo
    # pciutils
    # fwupd
    # killall
    # neofetch
    # p7zip
    # unrar
    # whois
    # libnotify

    wget
    curl
    git
    mc
    dnsutils

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    bpftrace # powerful tracing tool
    tcpdump # network sniffer
    lsof # list open files

    # system monitoring
    sysstat
    iotop
    iftop
    btop
    nmon
    sysbench

    # system tools
    psmisc # killall/pstree/prtstat/fuser/...
    plocate # a much faster locate
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    hdparm # for disk performance, command
    smartmontools # S.M.A.R.T.
    dmidecode # a tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard
    parted
    alsa-utils # ALSA, the Advanced Linux Sound Architecture utils
  ];

  # replace default editor with neovim
  environment.variables.EDITOR = "nano";
}
