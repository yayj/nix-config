{ pkgs, ... }: {
  # Pacages without configurations
  home.packages = with pkgs; [ fd neofetch rsync tree ];

  # Packages with configurations
  imports = [
    ./bat.nix
    ./emacs.nix
    ./fzf.nix
    ./git.nix
    ./zsh.nix
  ];
}
