{
  lib,
  modules,
  ...
}: {
  homebrew = {
    casks =
      [
        "bettertouchtool"
        "cloudflare-warp"
        "contexts"
        "emacs-app"
        "karabiner-elements"
        "keepingyouawake"
        "kitty"
        "loop"
        "raycast"
        "snipaste"
        "squirrel-app"
      ]
      ++ lib.optionals (builtins.elem "browsers" modules) [
        "arc"
        "tor-browser"
      ]
      ++ lib.optionals (builtins.elem "im" modules) [
        "signal"
        "viber"
      ]
      ++ lib.optionals (builtins.elem "utilities" modules) [
        "adobe-acrobat-reader"
        "appcleaner"
        "iina"
        "thunderbird"
        "wireshark-app"
        "zoom"
      ];
    masApps =
      {
        "Bitwarden" = 1352778147;
        "Hidden Bar" = 1452453066;
        "Windows App" = 1295203466;
      }
      // lib.optionalAttrs (builtins.elem "im" modules) {
        "Telegram" = 747648890;
        "Whatsapp" = 310633997;
      }
      // lib.optionalAttrs (builtins.elem "office" modules) {
        "Microsoft PowerPoint" = 462062816;
        "Microsoft Word" = 462054704;
        "Microsoft Excel" = 462058435;
      }
      // lib.optionalAttrs (builtins.elem "xcode" modules) {
        "Xcode" = 497799835;
      };
  };
}
