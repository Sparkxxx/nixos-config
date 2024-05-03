## https://github.com/tolgaerok/nixos-kde/blob/main/core/gpu/nvidia/nvidia-stable-opengl/default.nix

{ config, pkgs, lib, ... }:

with lib;

{
  #---------------------------------------------------------------------
  # Runs well on my GPU: NVIDIA GeForce GT 1030/PCIe/SSE2
  #---------------------------------------------------------------------
  imports = [

    #---------------------------------------------------------------------
    # Nvidia virtulation for Docker/Virtulization
    #---------------------------------------------------------------------
    ./nvidia-docker.nix
    ./vaapi.nix
    ../openGL/opengl.nix
    ../included/cachix.nix

  ];

  hardware = {
    enableAllFirmware = true;
    nvidia = {
      modesetting.enable = true;
      nvidiaPersistenced = true;

      #---------------------------------------------------------------------
      # Enable the nvidia settings menu
      #---------------------------------------------------------------------
      nvidiaSettings = true;

      #---------------------------------------------------------------------
      # Enable power management (do not disable this unless you have a reason to).
      # Likely to cause problems on laptops and with screen tearing if disabled.
      #---------------------------------------------------------------------
      powerManagement.enable = true;         # Fix Suspend issue

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      #---------------------------------------------------------------------
      # not sure it works check -  https://github.com/tolgaerok/nixos-kde/blob/main/core/gpu/nvidia/prime-optimus/laptop-nvidia.nix
      #---------------------------------------------------------------------

      #prime = {
      #  offload = {
      #    enable = lib.mkOverride 990 true;
      #    enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true; # Provides `nvidia-offload` command.
      #  };

        # Hardware should specify the bus ID for intel/nvidia devices
        # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA 
      #  nvidiaBusId = "PCI:1:0:0";  # Swap with "amdBusId" if using AMD
  
        # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA - set it to primary display in bios !!!
      #  intelBusId = "PCI:0:2:0"; 
      #};

      #---------------------------------------------------------------------
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      # Check legacy drivers https://www.nvidia.com/en-us/drivers/unix/legacy-gpu/
      # beta, production, stable, legacy_XXX
      # cat /proc/driver/nvidia/version
      #---------------------------------------------------------------------
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      vaapi = {
        enable = true;
        firefox.enable = true;
      };

    };
  };

  boot.extraModprobeConfig = "options nvidia " + lib.concatStringsSep " " [
    # nvidia assume that by default your CPU does not support PAT,
    # but this is effectively never the case in 2023
    "NVreg_UsePageAttributeTable=1"
    # This may be a noop, but it's somewhat uncertain
    "NVreg_EnablePCIeGen3=1"
    # This is sometimes needed for ddc/ci support, see
    # https://www.ddcutil.com/nvidia/
    #
    # Current monitor does not support it, but this is useful for
    # the future
    "NVreg_RegistryDwords=RMUseSwI2c=0x01;RMI2cSpeed=100"
    # When (if!) I get another nvidia GPU, check for resizeable bar
    # settings
  ];

  # Replace a glFlush() with a glFinish() - this prevents stuttering
  # and glitching in all kinds of circumstances for the moment.
  #
  # Apparently I'm waiting for "explicit sync" support, which needs to
  # land as a wayland thing. I've seen this work reasonably with VRR
  # before, but emacs continued to stutter, so for now this is
  # staying.
  nixpkgs.overlays = [
    (_: final: {
      wlroots_0_16 = final.wlroots_0_16.overrideAttrs
        (_: { patches = [ ./wlroots-nvidia.patch ]; });
    })
  ];

  #---------------------------------------------------------------------
  # Set environment variables related to NVIDIA graphics:
  #---------------------------------------------------------------------
  environment.variables = {
    # Required to run the correct GBM backend for nvidia GPUs on wayland
    GBM_BACKEND = "nvidia-drm";
    # Apparently, without this nouveau may attempt to be used instead (despite it being blacklisted)
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # Hardware cursors are currently broken on nvidia
    LIBVA_DRIVER_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    __GL_THREADED_OPTIMIZATION = "1";
    __GL_SHADER_CACHE = "1";

    
  };

  #---------------------------------------------------------------------
  # Packages related to NVIDIA graphics:
  #---------------------------------------------------------------------
  environment.systemPackages = with pkgs; [

    clinfo
    gwe
    nvtop-nvidia
    virtualglLib
    vulkan-loader
    vulkan-tools

  ];

}
