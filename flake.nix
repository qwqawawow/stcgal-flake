{
  description = "stcgal flake";

  inputs = {
    nixpkgs = {
      type = "indirect";
      id = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs }:
    {
      packages.x86_64-linux = with nixpkgs.legacyPackages.x86_64-linux.python3Packages; rec {
        stcgal = (callPackage ./default.nix { });
        default = toPythonApplication stcgal;
      };
    };
}
