{ pkgs, ... }: {
  home.packages = with pkgs; [ netcat-openbsd nettools ];
  imports = [ ./tmux.nix ];
}
