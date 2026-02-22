{ lib, config, pkgs, ... }:

{
  options.global = {
  
    ##### GENERAL SETTING ######################################
    
    user = lib.mkOption { type = lib.types.str; default = "franz"; };
    timeZone = lib.mkOption { type = lib.types.str; default = "Europe/Oslo"; };
    default_desktop_environment = lib.mkOption { type = lib.types.str; default = "gnome"; };
    defaultBrowser = lib.mkOption { type = lib.types.package; default = pkgs.firefox; };
    defaultTerminal = lib.mkOption { type = lib.types.package; default = pkgs.kitty; };
    defaultShell = lib.mkOption { type = lib.types.str; default = "fish"; };
    bluetoothEnabled = lib.mkOption { type = lib.types.bool; default = true; };
    isLaptop = lib.mkOption { type = lib.types.bool; default = false; };
    
    #### GAMING SETUP ###########################################
    
    extraScrapeFlags = lib.mkOption { type = lib.types.str; default = "--flags unattend,symlink,videos,manuals,fanarts,nobrackets,theinfront,backcovers"; };
    romDir = lib.mkOption { type = lib.types.str; default = "/home/franz/Games/ROMs"; };
    screenscraperUser = lib.mkOption { type = lib.types.str; default = "IceCubeMaker:Pokemon"; };
    emulationPlatforms = lib.mkOption { type = lib.types.listOf lib.types.str; default = [ "nintendo" ];
      description = "List of platforms to enable (e.g., [ 'snes' 'gba' 'ps2' ], or [ 'nintendo' '8-bit' 'handhelds'])";
    };
    
    ### STUDYING SETUP ###########################################
    pomodoroTimer = lib.mkOption { type = lib.types.package; default = pkgs.solanum; };
    noteTakingProgram = lib.mkOption { type = lib.types.package; default = pkgs.obsidian; };
    syncService = lib.mkOption { type = lib.types.package; default = pkgs.syncthing; };
  };
}
