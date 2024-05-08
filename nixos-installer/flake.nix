{
  description = "NixOS configuration of sparkx";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    impermanence.url = "github:nix-community/impermanence";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nuenv.url = "github:DeterminateSystems/nuenv";
    #url = "github:nix-community/haumea/v0.2.2";
  };

  outputs = inputs @ {
    nixpkgs,
    nixos-hardware,
    ...
  }: {
    nixosConfigurations = {
      twr-z790 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs // {myvars.username = "sparkx";};
        modules = [
          {networking.hostName = "twr-z790";}

          ./configuration.nix

          ../modules/base.nix
          ../modules/nixos/base/i18n.nix
          ../modules/nixos/base/user-group.nix
          ../modules/nixos/base/networking.nix

          ../hosts/twr-z790/hardware-configuration.nix
          ../hosts/twr-z790/impermanence.nix
        ];
      };

      # shoukei = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   specialArgs = inputs // {myvars.username = "ryan";};
      #   modules = [
      #     # Building on a USB installer is buggy, lack of disk space, memory, trublesome to setup substituteers, etc.
      #     # so we disable apple-t2 module here to avoid build kernel during the initial installation, and enable it after the first boot.
      #     # nixos-hardware.nixosModules.apple-t2
      #     ({pkgs, ...}: {
      #       networking.hostName = "shoukei";
      #       boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel for the initial installation.
      #       # hardware.apple-t2.enableAppleSetOsLoader = true;
      #     })

      #     ./configuration.nix

      #     ../modules/base.nix
      #     ../modules/nixos/base/i18n.nix
      #     ../modules/nixos/base/user-group.nix
      #     ../modules/nixos/base/networking.nix

      #     ../hosts/12kingdoms-shoukei/hardware-configuration.nix
      #     ../hosts/idols-ai/impermanence.nix
      #   ];
      # };
    };
  };
}
