{ pkgs, lib, homeDirectory, isDarwin, ... }: {
  programs.zsh = {
    enable = true;

    package = if isDarwin then pkgs.emptyDirectory else pkgs.zsh;

    defaultKeymap = "emacs";

    sessionVariables = {
      EDITOR = "emacsclient -a '' -t";
      PAGER = "bat";
    } // lib.optionalAttrs isDarwin {
      HOMEBREW_AUTO_UPDATE_SECS = "432000";
      HOMEBREW_INSTALL_CLEANUP = "1";
      HOMEBREW_CURLRC = "true";
    } // lib.optionalAttrs (!isDarwin) {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    shellAliases = {
      em = "emacsclient -a '' -t";
      eeval = "emacsclient -e";

      gl = "git gl";
      gla = "git gla";
      glv = "git glv";
      glav = "git glav";
      gs = "git st";

      j = "jobs -l";
    };

    oh-my-zsh = {
      enable = true;
      custom = "${homeDirectory}/.omz";
      plugins = [ "fzf" "git" "kitty" "rsync" ] ++
                lib.optionals isDarwin [ "brew" ];
      theme = "matt";
    };

    profileExtra = ''
      ${pkgs.neofetch}/bin/neofetch
    '';
  };

  home.file.".omz/themes/matt.zsh-theme".source = ./zsh/matt-theme.zsh;
}
