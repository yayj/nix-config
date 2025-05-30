{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    keyMode = "emacs";
    mouse = true;
    shortcut = "q";

    extraConfig = builtins.readFile ../misc/tmux.conf;
  };
}
