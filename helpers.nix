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
  in
    pkgs.buildEnv {
      name = "${hostname}-env";
      paths = with pkgs;
        [
          alejandra
          bat
          btop
          clang-tools
          diff-so-fancy
          fastfetch
          fd
          fzf
          just
          nodePackages.prettier
          p7zip
          rsync
          stow
          tree
          tshark
        ]
        ++ lib.optionals (builtins.elem "cmake" modules) [
          cmake
          cmake-format
          ninja
        ]
        ++ lib.optionals (builtins.elem "gpg" modules) [
          gnupg
          pinentry_mac
        ]
        ++ lib.optionals (builtins.elem "server" modules) [
          emacs-nox
          file
          gcc
          git
          netcat-openbsd
          nettools
          tmux
          zsh
        ]
        ++ lib.optionals (builtins.elem "tor" modules) [tor];
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
  }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit username hostname system disko;
      };
      modules = [./nixos];
    };

  isDarwin = {system, ...}: builtins.elem system ["aarch64-darwin" "x86_64-darwin"];
  isNixos = {modules, ...}: builtins.elem "nixos" host.modules;
}
