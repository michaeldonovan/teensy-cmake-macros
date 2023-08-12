{
  description = "A flake for newdigate/teensy-cmake-macros";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }@inputs:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = with pkgs;{
          pkg = pkgs.stdenv.mkDerivation {
            pname = "teensy-cmake-macros";
            src = ./.;
            version = "0.0.1";

            outputs = [ "out" ];  

            propagatedBuildInputs = [ cmake ];

            meta = with lib; {
              description = "build teensy apps and libraries using cmake and gcc-arm-none-eabi";
              license = licenses.mit;
              platforms = platforms.all;
            };
          };
        };

        defaultPackage = self.packages.${system}.pkg;
      });
}
