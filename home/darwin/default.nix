_: {
  imports = [
    # Command line tools
    ./gpg.nix
    ./ssh.nix

    # Configurations exclusive to darwin
    ./karabiner.nix
    ./kitty.nix
    ./rime.nix
    ./snipaste.nix
  ];
}
