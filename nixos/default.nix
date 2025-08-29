{
  disko,
  hostname,
  ...
}: {
  imports = [
    disko.nixosModules.disko
    ./common.nix
    ./${hostname}.nix
  ];

  system.stateVersion = "25.05";
}
