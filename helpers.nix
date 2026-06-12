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
            emacs
            nodePackages.prettier
          ]
          ++ lib.optionals (!isDarwin) [clang-tools]
        )
        ++ lib.optionals (builtins.elem "gnupg" modules) (
          [gnupg]
          ++ (
            if isDarwin
            then [pinentry_mac]
            else [pinentry-tty]
          )
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
