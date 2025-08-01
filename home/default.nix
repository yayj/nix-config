{ lib, username, stateVersion, homeDirectory, isDarwin, isServer, pkgs, ... }: {
  programs.home-manager.enable = true;

  home = {
    inherit homeDirectory username stateVersion;
    packages = with pkgs; [
      bat
      btop
      diff-so-fancy
      fastfetch
      fd
      fzf
      just
      p7zip
      rsync
      stow
      tree
      tshark
    ] ++ lib.optionals isDarwin [
      gnupg
      pinentry_mac
    ] ++ lib.optionals isServer [
      emacs-nox
      git
      netcat-openbsd
      nettools
      tmux
      zsh
    ];
  };
}
