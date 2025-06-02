{ pkgs, inputs, ... }:
with inputs;
{
  imports = [
    nix-homebrew.darwinModules.nix-homebrew
    ./configuration.nix
    ./packages.nix
    ./casks.nix
  ];
}
