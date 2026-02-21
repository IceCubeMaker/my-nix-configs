{ config, lib, pkgs, ... }:

let
  # This pulls the latest unstable nixpkgs
  unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
    config = config.nixpkgs.config; # Ensures unfree settings carry over
  };
in {

    environment.systemPackages = with pkgs; [

    ncdu	    # For deleting files and debloating
    python3 	    # Dependency for many programs
    kitty 	    # Terminal Emulator
    ranger	    # CLI File Browser
    neovim          # CLI Text Editor
    wget	    # CLI download tool
    git 	    # Git
    github-desktop  # Desktop version of Github
    brightnessctl   # Bright --updateness Controls
    blueman 	    # For bluetooth
    revolt-desktop  # Revolt / Stoat
    nodejs_20       # NodeJS
    fastfetch
    pavucontrol
    ];

    programs.firefox = {
       enable = true;
       preferences = {
          "widget.user-xdg-desktop-portal.file-picker" = 1;
       };
    };

    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

    services.dbus.enable = true;

    # enable bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    # enable audio
    services.pipewire = {
       enable = true;
       alsa.enable = true;
       alsa.support32Bit = true;
       pulse.enable = true;
       jack.enable = true;
    };

    # enable fish shell
    programs.fish.enable = true;
    
    # set timezone, keyboard and language
    time.timeZone = "Europe/Oslo";
    i18n.defaultLocale = "en_US.UTF-8";

    # reduce how much space Nix takes
    nix.settings.auto-optimise-store = true;
    boot.loader.systemd-boot.configurationLimit = 7;
    nix.gc = {
       automatic = true;
       dates = "weekly";
       options = "--delete-older-than +7";
    };

    # optimize RAM usage
    zramSwap = {
       enable = true;
       algorithm = "lz4";
       memoryPercent = 50;
       priority = 100;
    };

    # enable internet
    networking.networkmanager.enable = true;

    # enable boot screen
    boot.plymouth = {
       enable = true;
       theme = "breeze";
    };

    # log if someone tries to connect to a closed port
    networking.firewall.logRefusedConnections = true;

}
