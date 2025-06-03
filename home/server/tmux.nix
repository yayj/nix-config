{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    keyMode = "emacs";
    mouse = false;
    shortcut = "q";

    extraConfig = builtins.readFile ./tmux/tmux.conf;
  };
}
