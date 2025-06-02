{ inputs, outputs, stateVersion }: {
  mkHome = { hostname, system, username ? "matt", withGpg ? false , isServer ? true }:
    with inputs;
    let isDarwin = builtins.match ".*-darwin" system == [ ];
    in home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};

      modules = [ ../home ];

      extraSpecialArgs = {
        inherit inputs outputs username stateVersion isDarwin withGpg isServer;
        homeDirectory =
          if isDarwin then "/Users/${username}" else "/home/${username}";
      };
    };

  mkDarwin = {hostname, system, username ? "matt"}:
    with inputs;
    nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs outputs username hostname system;
      };
      modules = [ ../darwin ];
    };
}
