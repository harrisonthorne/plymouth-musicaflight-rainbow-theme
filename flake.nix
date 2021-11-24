{
  description = "The Musicaloft rainbow logo Plymouth theme";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        packages.plymouth-theme-musicaloft-rainbow =
          derivation {
            inherit system;
            name = "plymouth-theme-musicaloft-rainbow";
            builder = "${pkgs.bash}/bin/bash";
            src = ./src;
            args = [
              "-c"

              ''
              ${pkgs.coreutils}/bin/mkdir -p $out/share/plymouth/themes/musicaloft-rainbow/
              ${pkgs.coreutils}/bin/cp -r $src/* $out/share/plymouth/themes/musicaloft-rainbow/
              ''
            ];
          };
        defaultPackage = packages.plymouth-theme-musicaloft-rainbow;
      }
    );
}
