{ lib, username, stateVersion, homeDirectory, isDarwin, isServer, ... }: {
  programs.home-manager.enable = true;

  home = {
    inherit username stateVersion;
    homeDirectory = homeDirectory;
  };

  imports = [
    ./common
    ./preferences
  ] ++ lib.optionals isDarwin [
    ./darwin
  ] ++ lib.optionals isServer [
    ./server
  ];
}
