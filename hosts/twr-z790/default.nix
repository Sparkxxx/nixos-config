{myvars, ...}:
#############################################################
#
#  twr-z790 - my main computer, with NixOS + I5-14500 + RTX 4060 GPU, for gaming & daily use.
#
#############################################################
let
  hostName = "twr-z790"; # Define your hostname.
in {
  imports = [
    ./netdev-mount.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Video devices
    ../../hardware/gpu/intel
    #../../hardware/gpu/nvidia

    # RGB devices
    ../../hardware/rgb

    ./impermanence.nix
    #./secureboot.nix
  ];

  # ## https://nixos.org/manual/nixos/stable/index.html#sec-ipv4
  # systemd.network.links."10-mobolan" = {
  #   matchConfig.PermanentMACAddress = "74:56:3c:c3:e5:3b";
  #   linkConfig.Name = "mobolan";
  # };

  # systemd.network.links."20-pcielan" = {
  #   matchConfig.PermanentMACAddress = "1c:86:0b:21:08:54";
  #   linkConfig.Name = "pcielan";
  # };

  # networking.enableIPv6 = false;

  # networking.interfaces.mobolan.ipv4.addresses = [ {
  #   address = "10.111.0.220";
  #   prefixLength = 24;
  # } ];

  #networking.defaultGateway = "10.111.0.1";
  #networking.nameservers = [ "10.111.0.1" ];

  networking = {
    inherit hostName;
    enableIPv6 = false;

    interfaces.enp3s0.ipv4.addresses = [
      {
        address = "10.111.0.220";
        prefixLength = 24;
      }
    ];

    defaultGateway = "10.111.0.1";
    nameservers = [
      "10.111.0.1" # t0mm-gw
      "10.215.0.1" # opnsfw.ops.t0mm.iotec.ro:65456
    ];

    # desktop need its cli for status bar
    networkmanager.enable = true;
  };

  # conflict with feature: containerd-snapshotter
  virtualisation.docker.storageDriver = "btrfs";

  services.xserver.videoDrivers = ["nvidia"]; # will install nvidia-vaapi-driver by default
  #services.xserver.videoDrivers = ["i915"]; #

  hardware.nvidia = {
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix
    # package = config.boot.kernelPackages.nvidiaPackages.stable;

    # required by most wayland compositors!
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  virtualisation.docker.enableNvidia = true; # for nvidia-docker
  # libnvidia-container does not support cgroups v2 (prior to 1.8.0)
  # https://github.com/NVIDIA/nvidia-docker/issues/1447
  # setting enableUnifiedCgroupHierarchy to true will conflict with virtualisation.nix -> lxd.enable = true;
  systemd.enableUnifiedCgroupHierarchy = true;

  hardware.opengl = {
    enable = true;
    # if hardware.opengl.driSupport is enabled, mesa is installed and provides Vulkan for supported hardware.
    driSupport = true;
    # needed by nvidia-docker
    driSupport32Bit = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
