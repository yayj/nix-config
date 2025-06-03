{ pkgs, homeDirectory, isDarwin, ... }: {
  home.sessionVariables.SSH_AUTH_SOCK =
    "${homeDirectory}/.gnupg/S.gpg-agent.ssh";

  programs.gpg = {
    enable = true;
    settings = {
      cipher-algo = "AES256";
      keyid-format = "long";
      with-fingerprint = false;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentry.package =
      if isDarwin then pkgs.pinentry_mac else pkgs.pinentry-tty;
    sshKeys = [
      "384381F78B1826F3C6244488A106F408BC9766F9"
      "56A51185BD27C000ED8098D42DAC05C0659C5BCE"
    ];
  };
}
