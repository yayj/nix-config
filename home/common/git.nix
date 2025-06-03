{ pkgs, ... }: {
  programs.git = {
    enable = true;

    package = pkgs.emptyDirectory;

    aliases = {
      br = "branch";

      ci = "commit";
      co = "checkout";

      df = "diff";
      dfc = "df --cached";

      gl =
        "log --graph --pretty='%C(yellow)%h%Creset%C(auto)%d %Creset%s %C(blue)%aN%Creset'";
      gla = "gl --all";
      glv =
        "log --graph --pretty='%C(yellow)%h%Creset%C(auto)%d %Creset%s %C(blue)%aN%Creset%C(green)[%G?]'";
      glav = "glv --all";

      st = "status -s";
    };

    diff-so-fancy.enable = true;

    extraConfig = {
      core = {
        autocrlf = "input";
        quotepath = false;
      };
      color.ui = true;
      init.defaultBranch = "main";
    };

    userName = "Qiru Yang";
    userEmail = "yayjsir@gmail.com";

    signing = {
      format = "openpgp";
      key = "CC59580A1AFB339E";
      signByDefault = true;
    };
  };
}
