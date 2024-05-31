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

    ./impermanence.nix
    #./secureboot.nix
  ];

  networking = {
    inherit hostName;
    #inherit (myvars.networking) defaultGateway nameservers; - these have been moved to interfaces in ../../vars/networking.nix
    inherit (myvars.networking) defaultGateway nameservers;
    inherit (myvars.networking.hostsInterface.${hostName}) interfaces;

    # desktop need its cli for status bar
    networkmanager.enable = true;
  };

  # conflict with feature: containerd-snapshotter
  # virtualisation.docker.storageDriver = "btrfs";

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
