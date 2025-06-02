{ xdg, ... }: {
  xdg.configFile = {
    "kitty/kitty.conf".source = ./kitty.conf;
    "kitty/matt.conf".source = ./matt.conf;
  };
}
