{
  inputs,
  lib,
  system,
  genSpecialArgs,
  nixos-modules,
  home-modules ? [],
  specialArgs ? (genSpecialArgs system),
  myvars,
  ...
}: let
  inherit (inputs) nixpkgs home-manager nixos-generators;
in
  nixpkgs.lib.nixosSystem {
    inherit system specialArgs;
    modules =
      nixos-modules
      ++ [
        nixos-generators.nixosModules.all-formats
      ]
      ++ (
        lib.optionals ((lib.lists.length home-modules) > 0)
        [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;

            #installation of user packages through the {option}`users.users.<name>.packages` option
            home-manager.useUserPackages = true;

            # On activation move existing files by appending the given file extension rather than exiting with an error.
            # Without it you get errors that config files `are in the way of ...` and home-manager generate config fails !!!
            # When the above happens everything defined in programs={} fail to build, eg: extensions for vscode
            home-manager.backupFileExtension = "backup";

            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users."${myvars.username}".imports = home-modules;
          }
        ]
      );
  }
