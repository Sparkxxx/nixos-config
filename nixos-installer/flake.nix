
## Check the flake with:
## nix flake check --extra-experimental-features "nix-command flakes"

{
  description = "NixOS configuration of sparkx";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    impermanence.url = "github:nix-community/impermanence";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nuenv.url = "github:DeterminateSystems/nuenv";
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixos-hardware,
    ...
  }: {
    nixosConfigurations = {
      twr-z790 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs // { 
            # Quickhack to have these variabiles for 1'st flake install
            myvars.username = "sparkx"; myvars.userfullname = "sparkx"; 
          };
        modules = [
          {networking.hostName = "twr-z790";}

          ./configuration.nix

          ../modules/base.nix
          ../modules/nixos/base/i18n.nix
          ../modules/nixos/base/user-group.nix
          ../modules/nixos/base/ssh.nix # Autogen system ssh keys from /etc/ssh/ ssh_host_rsa_key + ssh_host_ed25519_key
          ../modules/nixos/base/networking.nix

          ../hosts/twr-z790/hardware-configuration.nix
          ../hosts/twr-z790/impermanence.nix
        
        ];
      };
    };
  };
}
