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
    let allSystems =
      flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          package =
            pkgs.stdenv.mkDerivation {
              pname = "plymouth-theme-musicaloft-rainbow";
              version = "0.0.1";

              src = builtins.path { path = ./.; name = "plymouth-theme-musicaloft-rainbow"; };

              buildInputs = [ ];

              configurePhase = "mkdir -pv $out/share/plymouth/themes/";
              dontBuild = true;
              installPhase = ''
                cp -rv musicaloft-rainbow/ $out/share/plymouth/themes/
                substituteInPlace $out/share/plymouth/themes/musicaloft-rainbow/musicaloft-rainbow.plymouth \
                  --replace "/usr/" "$out/"
              '';
            };
        in
        {
          packages.plymouth-theme-musicaloft-rainbow = package;
          defaultPackage = package;
        }
      );
    in
    {
      packages = allSystems.packages;
      defaultPackage = allSystems.defaultPackage;
      overlay = final: prev: {
        plymouth-theme-musicaloft-rainbow =
          allSystems.packages.${final.system}.plymouth-theme-musicaloft-rainbow;
      };
    };
}
