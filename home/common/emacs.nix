{ pkgs, isServer, ... }: {
  programs.emacs = {
    enable = true;
    package = if isServer then pkgs.emacs-nox else pkgs.emacs;

    extraPackages = epkgs: with epkgs; [
      ace-window
      aggressive-indent
      command-log-mode
      counsel
      doom-modeline
      ivy
      ivy-rich
      magit
      nerd-icons
      nix-mode
      solarized-theme
      swiper
      treesit-grammars.with-all-grammars
      use-package
    ];

    extraConfig = builtins.readFile ./emacs/init.el;
  };
}
