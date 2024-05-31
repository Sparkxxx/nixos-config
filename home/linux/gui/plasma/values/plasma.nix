{
  pkgs,
  lib,
  plasma,
  #nur-ryan4yin,
  ...
}: let
  package = plasma.packages.${pkgs.system}.plasma;
in {
    
}
