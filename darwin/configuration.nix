{
  pkgs,
  lib,
  username,
  hostname,
  system,
  ...
}: {
  nix.enable = false;

  documentation.enable = false;

  fonts.packages = with pkgs; [fira fira-code nerd-fonts.fira-code lxgw-wenkai];

  homebrew.enable = true;
  homebrew.onActivation = {
    cleanup = "zap";
    autoUpdate = true;
    upgrade = true;
  };

  networking = {
    hostName = hostname;
    computerName = hostname;
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = system == "aarch64-darwin";
    autoMigrate = false;
    user = username;
    mutableTaps = true;
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault system;
  };

  security.pam.services.sudo_local.enable = true;

  system = {
    stateVersion = 6;
    primaryUser = username;

    defaults = {
      controlcenter = {
        AirDrop = true;
        BatteryShowPercentage = true;
      };

      dock = {
        autohide = true;
        orientation = "bottom";
        show-recents = false;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };

      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "clmv";
        NewWindowTarget = "Other";
        NewWindowTargetPath = "file:///tmp";
      };

      iCal."first day of week" = "Monday";

      menuExtraClock = {
        ShowAMPM = false;
        ShowDate = 1; # Always
        ShowSeconds = false;
        Show24Hour = true;
      };

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };
}
