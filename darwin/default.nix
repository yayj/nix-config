{ nix-homebrew, ... }: {
  imports = [
    nix-homebrew.darwinModules.nix-homebrew
    ./configuration.nix
    ./casks.nix
  ];
}
