{
  description = "Nix Configurations of Qiru Yang";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    let
      inherit (self) outputs;
      helper = import ./helpers {
        inherit inputs outputs;
        stateVersion = "25.05";
      };
    in {
      homeConfigurations = {
        Freedom = helper.mkHome {
          hostname = "Freedom";
          system = "x86_64-darwin";
          withGpg = true;
          isServer = false;
        };
        cc = helper.mkHome {
          hostname = "cc";
          system = "x86_64-linux";
        };
        ros = helper.mkHome {
          hostname = "ros";
          system = "aarch64-linux";
         };
      };
      darwinConfigurations = {
        Freedom = helper.mkDarwin {
          hostname = "Freedom";
          system = "x86_64-darwin";
        };
      };
    };
}
