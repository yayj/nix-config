{ pkgs, inputs, ... }:
with inputs;
{
  imports = [
    nix-homebrew.darwinModules.nix-homebrew
    ./configuration.nix
    ./casks.nix
  ];
}
