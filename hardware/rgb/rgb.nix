{pkgs, ...}: {
  #============================= Audio(PipeWire) =======================

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    i2c-tools # Set of I2C tools for Linux
    
    # Linux led controller for Logitech G213, G410, G413, G512, G513, G610, G810, G815, G910 and GPRO Keyboards.
    # https://github.com/MatMoul/g810-led
    g810-led

    # https://openrgb.org/
    # https://discourse.nixos.org/t/guide-to-setup-openrgb-on-nixos/9093
    openrgb-with-all-plugins # Open source RGB lighting control
  ];
}