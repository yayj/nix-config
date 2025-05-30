{ pkgs, ... }: {
  programs.ssh = {
    enable = true;
    package = pkgs.emptyDirectory;

    compression = true;
    forwardAgent = true;

    matchBlocks = {
      "3po" = {
        hostname = "172.27.253.1";
        user = "qiru";
      };
      cc = {
        hostname = "172.27.252.1";
        user = "matt";
      };
      fat = {
        hostname = "172.27.251.1";
        user = "matt";
      };
      github = {
        hostname = "github.com";
        user = "git";
      };
      ros = {
        hostname = "172.27.240.1";
        user = "matt";
      };
    };
  };
}
