{
  lib,
  pkgs,
  system,
  username,
  ...
}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = ["sd_mod" "sr_mod"];
      kernelModules = [];
    };
    tmp.cleanOnBoot = true;
  };

  documentation = {
    enable = true;
    nixos.enable = false;
    man.enable = true;
    info.enable = false;
    doc.enable = false;
  };

  environment = {
    systemPackages = with pkgs; [git rsync];
  };

  i18n = {
    defaultCharset = "UTF-8";
    defaultLocale = "en_US.UTF-8";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.hostPlatform = lib.mkDefault system;

  programs.zsh.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  services.openssh.enable = true;

  users.users.${username} = {
    enable = true;
    isNormalUser = true;
    group = "users";
    extraGroups = ["docker" "wheel"];
    initialHashedPassword = "$y$j9T$jygbX4w8Vmo.nmelR3EM6.$p.5DC20gdHsqLfEKKS/s6r7gmzg01ikB2NqJvslwgO1";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF0N2eKRGPJre2v+t59NzR2nVvVcTK/W9izQgZRSQ+XJ openpgp:0xB8C46362"
      "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAkqQA7X/o0mSYgqCf9hLtQKGY0bO0QZA0JdRK4Svjvj6Oiy7wu1Rvj5b5DKUUZcHeg9L65W+S4SneGukeTbgh5hvXJ4XAXRcSm9yF9Avx7gbAkCT8jNcVYc+g0VEopWE8nSflv8HYmuPt17MeXBZ0x2eDhh7oIlDt4SZAuHB8GgouyVf3njep4RkV+qZMuYmyN2zdZI3jmUoD8TArZl/erita1dtHz/LK3jVF5gAibj4k1M7zPsTVFnwUHyXGyp6VLdkYcezjg8JkNWqDdLLadmdOt3ctQkTN1yhl02xGGj9m1aCaKaemt5HMR1g9Dh9liR9eWQxIZNkJZRWX0uIzcQ== PC-HOME"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJwZ8/QDWC86s7ZhLtQ4z4ACkAneGm9lD4Z+7AmsOmSR Contra"
    ];
    shell = pkgs.zsh;
    uid = 1024;
  };

  virtualisation = {
    docker.enable = true;
    hypervGuest.enable = true;
  };
}
