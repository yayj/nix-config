{inputs, ...}:
with inputs; {
  imports = [
    nix-homebrew.darwinModules.nix-homebrew
    ./applications.nix
    ./configuration.nix
  ];
}
