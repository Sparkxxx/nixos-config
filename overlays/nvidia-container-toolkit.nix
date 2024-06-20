{
  nixpkgs,
  nixpkgs-unstable,
  ...
}: {
  overlay-unstable = final: prev: {
    unstable = nixpkgs-unstable.legacyPackages.${prev.system};
    nvidia-container-toolkit = nixpkgs-unstable.legacyPackages.${prev.system}.nvidia-container-toolkit;
  };
}
