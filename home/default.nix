{ pkgs, lib, username, stateVersion, homeDirectory, isDarwin, isServer, withGpg, ... }: {
  imports = [
    ./modules/bat.nix
    ./modules/emacs.nix
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/zsh.nix

    ./preferences
  ] ++ lib.optionals withGpg [
    ./modules/gpg.nix
  ] ++ lib.optionals isDarwin [
    ./modules/ssh.nix
  ] ++ lib.optionals isServer [
    ./modules/tmux.nix
  ];

  home = {
    inherit username stateVersion;
    homeDirectory = homeDirectory;

    packages = with pkgs; [ fd neofetch rsync tree ]
                          ++ lib.optionals (!isDarwin) [ netcat-openbsd nettools ];
  };
}
