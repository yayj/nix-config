inputs:
with inputs; let
  defaultUser = "matt";
in {
  buildEnv = hostname: {
    system,
    modules,
    ...
  }: let
    pkgs = nixpkgs.legacyPackages.${system};
    emacsWithPkgs = pkgs.emacs.pkgs.withPackages (epkgs:
      with epkgs; [
        ace-window
        aggressive-indent
        command-log-mode
        company
        counsel
        doom-modeline
        eglot
        format-all
        ivy
        ivy-rich
        just-mode
        magit
        markdown-mode
        nerd-icons
        nix-mode
        projectile
        solarized-theme
        swiper
        treesit-auto
        treesit-fold
        treesit-grammars.with-all-grammars
        vterm
        which-key
      ]);
    dSys = ["aarch64-darwin" "x86_64-darwin"];
    isDarwin = builtins.elem system dSys;
  in
    pkgs.buildEnv {
      name = "${hostname}-env";
      paths = with pkgs;
        [
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
        ]
        ++ lib.optionals (builtins.elem "dev" modules) (
          [
            cmake
            ninja
          ]
          ++ lib.optionals (!isDarwin) [
            gcc
            gnumake
            patchelf
          ]
        )
        ++ lib.optionals (builtins.elem "emacs" modules) (
          [
            alejandra
            cmake-format
            emacsWithPkgs
            prettier
          ]
          ++ lib.optionals (!isDarwin) [clang-tools]
        )
        ++ lib.optionals (builtins.elem "server" modules) [
          file
          git
          netcat-openbsd
          nettools
          tmux
          zsh
        ]
        ++ lib.optionals isDarwin [mas];
    };
  mkDarwin = hostname: {
    modules,
    system,
    username ? defaultUser,
  }:
    nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs username hostname modules system;
      };
      modules = [./darwin];
    };

  mkNixos = hostname: {
    system,
    username ? defaultUser,
    ...
  }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit username hostname system disko;
      };
      modules = [./nixos];
    };

  isDarwin = {system, ...}: builtins.elem system dSys;
  isNixos = {modules, ...}: builtins.elem "nixos" modules;
}
