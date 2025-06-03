{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;

    extraPackages = epkgs: with epkgs; [
      aggressive-indent
      magit
      nix-mode
      solarized-theme
      treesit-grammars.with-all-grammars
    ];

    extraConfig = builtins.readFile ./emacs/init.el;
  };
}
