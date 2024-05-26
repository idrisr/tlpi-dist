{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/23.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { nixpkgs, flake-utils, ... }:
    let
      system = flake-utils.lib.system.x86_64-linux;
      pkgs = nixpkgs.legacyPackages.${system};
      libtlpi = pkgs.callPackage ./. { };
    in {
      packages.${system}.default = libtlpi;
      devShells.${system} = {
        inherit libtlpi;
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            acl
            bear
            libcap
            libseccomp
            libselinux
            libxcrypt
            ccls
          ];
        };
      };
    };
}
