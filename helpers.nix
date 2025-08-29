inputs:
with inputs; let
  defaultUser = "matt";
in {
  buildEnv = hostname: {
    system,
    type,
    ...
  }: let
    pkgs = nixpkgs.legacyPackages.${system};
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
        ++ lib.optionals (type == "darwin") [
          gnupg
          pinentry_mac
        ]
        ++ lib.optionals (type != "darwin") [
          emacs-nox
          file
          gcc
          git
          netcat-openbsd
          nettools
          tmux
          zsh
        ];
    };
  mkDarwin = hostname: {
    system,
    type,
    username ? defaultUser,
  }:
    nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit username hostname system;
      };
      modules = [./darwin];
    };

  mkNixos = hostname: {
    system,
    type,
    username ? defaultUser,
  }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit username hostname system disko;
      };
      modules = [./nixos];
    };
}
