{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;

    extraPackages = epkgs: with epkgs; [ aggressive-indent nix-mode ];

    extraConfig = builtins.readFile ./emacs/init.el;
  };
}
