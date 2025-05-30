{ pkgs, lib, isDarwin, ... }: {
  programs.zsh = {
    enable = true;

    package = if isDarwin then pkgs.emptyDirectory else pkgs.zsh;

    autocd = true;

    defaultKeymap = "emacs";

    shellAliases = {
      "-" = "cd -";

      em = "emacsclient -a '' -t";
      eeval = "emacsclient -e";

      g = "git";
      gl = "git gl";
      gla = "git gla";
      glv = "git glv";
      glav = "git glav";
      gs = "git st";

      l = "ls -ahl";
      la = "ls -Ahl";
      ll = "ls -hl";
      ls = "ls --color=auto";
      lsa = "ls -ahl";

      j = "jobs -l";

      r-copy = "rsync -avz --progress -h";
      r-move = "rsync -avz --progress -h --remove-source-files";
      r-updt = "rsync -avzu --progress -h";
      r-sync = "rsync -avzu --delete --progress -h";
    } // lib.optionalAttrs isDarwin { kssh = "kitty +kitten ssh"; };

    initContent = ''
      # Loading prompt theme
      source ${../misc/matt-theme.zsh}
    '';

    profileExtra = ''
      ${pkgs.neofetch}/bin/neofetch
    '';
  };
}
