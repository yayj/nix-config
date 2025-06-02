{ lib, isDarwin, ... }: {
  imports = [ ] ++ lib.optionals isDarwin [
    ./karabiner
    ./kitty
    ./rime
  ];
}
