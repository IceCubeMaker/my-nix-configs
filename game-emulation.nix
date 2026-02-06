{ config, pkgs, ... }:

{

  

  ############################
  # Core Gaming Environment
  ############################
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  ############################
  # Emulation Frontend
  ############################
  environment.systemPackages = with pkgs; [
    # Launcher
    pegasus-frontend

    # Multi-system
    retroarch
    retroarch-assets
    retroarch-joypad-autoconfig

    # Sony
    duckstation
    pcsx2
    ppsspp
    rpcs3

    # Nintendo
    dolphin-emu
    cemu
    ryubing
    melonDS
    desmume

    # Sega
    flycast

    # Arcade / Classic
    mame
    scummvm
    dosbox
    vice
    openmsx
    fsuae

    # PC / Launchers
    steam
    lutris

    # Multiplayer
    parsec-bin

    skyscraper
    qt5.qtimageformats
  ];

  ############################
  # RetroArch Configuration
  ############################
  environment.etc."retroarch/retroarch.cfg".text = ''
    menu_driver = "xmb"
    savestate_auto_save = true
    savestate_auto_load = true

    # Achievements
    cheevos_enable = true
    cheevos_hardcore_mode_enable = false
    cheevos_leaderboards_enable = true
    cheevos_verbose_enable = true

    # Netplay
    netplay_enable = true
    netplay_nat_traversal = true
  '';

  ############################
  # Controller Support
  ############################
  services.udev.packages = with pkgs; [
    game-devices-udev-rules
  ];

  ############################
  # Audio / Video Latency
  ############################
  hardware.graphics.enable = true;

  ############################
  # Optional: Desktop Auto-Launch
  ############################
  services.xserver.desktopManager.session = [
    {
      name = "pegasus";
      start = ''
        exec ${pkgs.pegasus-frontend}/bin/pegasus-fe
      '';
    }
  ];




  # 2. Fix the "Unsupported image format" globally
  environment.sessionVariables = {
    QT_PLUGIN_PATH = [ "${pkgs.qt5.qtimageformats}/${pkgs.qt5.qtbase.qtPluginPrefix}" ];
  };

  systemd.tmpfiles.rules = [
    # 1. Create the ROM directory structure
    # Format: type  path  mode  user  group  age  argument
    "d /home/franz/Games 0755 franz users -"
    "d /home/franz/Games/ROMs 0755 franz users -"
    "d /home/franz/Games/ROMs/snes 0755 franz users -"
    "d /home/franz/Games/ROMs/n64 0755 franz users -"
    "d /home/franz/Games/ROMs/3Ds 0755 franz users -"
    "d /home/franz/Games/ROMs/nds 0755 franz users -"
    "d /home/franz/Games/ROMs/gba 0755 franz users -"
    "d /home/franz/Games/ROMs/wii 0755 franz users -"
    "d /home/franz/Games/ROMs/wii-u 0755 franz users-"
    "d /home/franz/Games/ROMs/switch 0755 franz users-"
    "d /home/franz/Games/ROMs/nes 0755 franz users-"
    "d /home/franz/Games/ROMs/gamecube 0755 franz users-"

    # Create the Pegasus config directory
    "d /home/franz/.config/pegasus-frontend 0755 franz users -"

    # Create the game_dirs.txt pointing to your new folders
    # The 'f' rule creates the file with the text in the last argument if it doesn't exist
    "f /home/franz/.config/pegasus-frontend/game_dirs.txt 0644 franz users - /home/franz/Games/ROMs"
  ];
}
