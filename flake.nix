{
  description = "The Musicaloft rainbow logo Plymouth theme";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        plymouth-theme-musicaloft-rainbow-package =
          pkgs.stdenv.mkDerivation {
            pname = "plymouth-theme-musicaloft-rainbow";
            version = "0.0.1";

            src = ./.;

            buildInputs = [];

            configurePhase = "mkdir -pv $out/share/plymouth/themes/";
            dontBuild = true;
            installPhase = ''
              ls -l
              cp -rv musicaloft-rainbow/ $out/share/plymouth/themes/
              substituteInPlace $out/share/plymouth/themes/musicaloft-rainbow/musicaloft-rainbow.plymouth \
                --replace "/usr/" "$out/"
            '';
          };
      in
      {
        packages.plymouth-theme-musicaloft-rainbow =
          plymouth-theme-musicaloft-rainbow-package;
        defaultPackage = plymouth-theme-musicaloft-rainbow-package;
      }
    );
}
