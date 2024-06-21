{
  config,
  lib,
  pkgs,
  ...
}: {
  # https://wiki.archlinux.org/title/Intel_graphics
  # boot.initrd.kernelModules = ["i915.enable_guc=3"];
  # Module i915.enable_guc=3 not found in directory /nix/store/gn45s3xk9wznkaq403wfl39mhqri7s94-linux-6.8.11-modules/lib/modules/6.8.11-xanmod1
  boot.initrd.kernelModules = ["i915"];

  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

  hardware.opengl.extraPackages = with pkgs; [
    (
      if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11")
      then vaapiIntel
      else intel-vaapi-driver
    )
    libvdpau-va-gl
    intel-media-driver
  ];
}
