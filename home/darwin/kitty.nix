{ xdg, ... }: {
  xdg.configFile = {
    "kitty/kitty.conf".source = ./kitty/kitty.conf;
    "kitty/matt.conf".source = ./kitty/matt.conf;
  };
}
