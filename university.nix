{ config, pkgs, ... }:

{
  # 1. Install the necessary packages
  environment.systemPackages = with pkgs; [
    obsidian
    syncthing
    solanum
    firefox
  ];

}
