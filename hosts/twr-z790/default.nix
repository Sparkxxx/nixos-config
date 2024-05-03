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
    #./netdev-mount.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Video devices
    ../../hardware/gpu/intel
    ../../hardware/gpu/nvidia

    #./impermanence.nix
    #./secureboot.nix
  ];

  networking = {
    inherit hostName;
    #inherit (myvars.networking) defaultGateway nameservers; - these have been moved to interfaces in ../../vars/networking.nix
    inherit (myvars.networking.hostsInterface.${hostName}) interfaces;

    # desktop need its cli for status bar
    networkmanager.enable = true;
  };

  # Failed to enable firewall due to the following error:
  #   firewall-start[2300]: iptables: Failed to initialize nft: Protocol not supported
  firewall.enable = false;


  # conflict with feature: containerd-snapshotter
  # virtualisation.docker.storageDriver = "btrfs";

  #services.xserver.videoDrivers = ["nvidia"]; # will install nvidia-vaapi-driver by default
  services.xserver.videoDrivers = ["i915"]; # 
  # Enable the KDE Plasma Desktop Environment.
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true; 

      # Configure keymap in X11
      xkb.layout = "us";
      xkb.variant = "";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
