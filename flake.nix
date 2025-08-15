{
  description = "Nix Configurations of Qiru Yang";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = { self, ... }@inputs:
    with inputs;
    let
      lib = nixpkgs.lib;
      helpers = import ./helpers.nix inputs;

      hosts = {
        cc = {
          system = "x86_64-linux";
          type = "linux";
        };
        Freedom = {
          system = "x86_64-darwin";
          type = "darwin";
        };
        Liberty = {
          system = "aarch64-darwin";
          type = "darwin";
        };
        nix-lab = {
          system = "x86_64-linux";
          type = "nixos";
        };
        ros = {
          system = "aarch64-linux";
          type = "linux";
        };
      };
    in {
      darwinConfigurations = lib.mapAttrs
        (name: host: helpers.mkDarwin name host)
        (lib.filterAttrs (_: host: host.type == "darwin") hosts);
      packages = lib.foldl' lib.recursiveUpdate {}
        (lib.mapAttrsToList
          (name: host: lib.setAttrByPath
            [host.system name]
            (helpers.buildEnv name host))
          hosts);
    };
}
