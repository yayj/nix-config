{
  description = "Nix Configurations of Qiru Yang";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    disko = {
      url = "github:nix-community/disko/v1.12.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs:
    with inputs; let
      lib = nixpkgs.lib;
      helpers = import ./helpers.nix inputs;

      hosts = {
        cc = {
          system = "x86_64-linux";
          modules = ["server"];
        };
        Freedom = {
          system = "x86_64-darwin";
          modules = ["browsers" "cmake" "gpg"];
        };
        Liberty = {
          system = "aarch64-darwin";
          modules = ["browsers" "cmake" "gpg" "im" "office" "tor" "utilities"];
        };
        nix-lab = {
          system = "x86_64-linux";
          modules = ["dev" "nixos" "server"];
        };
        ros = {
          system = "aarch64-linux";
          modules = ["server"];
        };
      };
    in {
      darwinConfigurations =
        lib.mapAttrs
        (name: host: helpers.mkDarwin name host)
        (lib.filterAttrs (_: host: helpers.isDarwin host) hosts);
      nixosConfigurations =
        lib.mapAttrs
        (name: host: helpers.mkNixos name host)
        (lib.filterAttrs (_: host: helpers.isNixos host) hosts);
      packages =
        lib.foldl' lib.recursiveUpdate {}
        (lib.mapAttrsToList (name: host:
          lib.setAttrByPath [host.system name] (helpers.buildEnv name host))
        hosts);
    };
}
