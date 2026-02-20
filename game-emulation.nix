{ config, pkgs, lib, ... }:


let

  # Map platforms to their specific launch commands
  platformMap = {
    "snes"             = "retroarch -L /run/current-system/sw/lib/retroarch/cores/snes9x_libretro.so";
    "gba"              = "retroarch -L /run/current-system/sw/lib/retroarch/cores/mgba_libretro.so";
    "nes"              = "retroarch -L /run/current-system/sw/lib/retroarch/cores/nestopia_libretro.so";
    "n64"              = "retroarch -L /run/current-system/sw/lib/retroarch/cores/parallel_n64_libretro.so";
    "gc"               = "dolphin-emu -e";
    "wii"              = "dolphin-emu -e";
    "wiiu"             = "cemu -g";
    "switch"           = "Ryujinx";
    "gb"               = "retroarch -L /run/current-system/sw/lib/retroarch/cores/mgba_libretro.so";
    "gbc"              = "retroarch -L /run/current-system/sw/lib/retroarch/cores/mgba_libretro.so";
    "3ds"              = "retroarch -L /run/current-system/sw/lib/retroarch/cores/citra_libretro.so";
    "megadrive"        = "retroarch -L /run/current-system/sw/lib/retroarch/cores/genesis_plus_gx_libretro.so";
    "saturn"           = "retroarch -L /run/current-system/sw/lib/retroarch/cores/yabause_libretro.so";
    "psx"              = "retroarch -L /run/current-system/sw/lib/retroarch/cores/pcsx_rearmed_libretro.so";
    "psp"              = "retroarch -L /run/current-system/sw/lib/retroarch/cores/ppsspp_libretro.so";
    "nds"              = "retroarch -L /run/current-system/sw/lib/retroarch/cores/desmume_libretro.so";
    "pc"               = "retroarch -L /run/current-system/sw/lib/retroarch/cores/dosbox_libretro.so";
    "neogeo"           = "retroarch -L /run/current-system/sw/lib/retroarch/cores/fbneo_libretro.so";
    "mame"             = "retroarch -L /run/current-system/sw/lib/retroarch/cores/mame_libretro.so";
    "gamegear"         = "retroarch -L /run/current-system/sw/lib/retroarch/cores/genesis_plus_gx_libretro.so";
    "wonderswancolor"  = "retroarch -L /run/current-system/sw/lib/retroarch/cores/beetle_wswan_libretro.so";
    "ps2"              = "retroarch -L /run/current-system/sw/lib/retroarch/cores/pcsx2_libretro.so";
    "dreamcast"        = "retroarch -L /run/current-system/sw/lib/retroarch/cores/flycast_libretro.so";
    "atari2600"        = "retroarch -L /run/current-system/sw/lib/retroarch/cores/stella_libretro.so";
    "pcengine"         = "retroarch -L /run/current-system/sw/lib/retroarch/cores/beetle_pce_fast_libretro.so";
    "mastersystem"     = "retroarch -L /run/current-system/sw/lib/retroarch/cores/genesis_plus_gx_libretro.so";
    "steam"            = "steam -silent steam://rungameid/";
  };
  
  # Define all your systems here once
  platforms = builtins.attrNames platformMap;
  
  romDirRules = map (p: 
    if p == "steam" then "d /home/franz/Games/ROMs/.steam 0755 franz users -"
    else "d /home/franz/Games/ROMs/${p} 0755 franz users -"
  ) platforms;
  pegasusRules = map (p: 
    if p == "steam" then "w+ /home/franz/.config/pegasus-frontend/game_dirs.txt - - - - /home/franz/Games/ROMs/.steam/.metadata\\n"
    else "w+ /home/franz/.config/pegasus-frontend/game_dirs.txt - - - - /home/franz/Games/ROMs/${p}/.metadata\\n"
  ) platforms;

  # Helper to generate the bash 'case' statement logic
  launchCase = lib.concatStringsSep "\n" (lib.mapAttrsToList (name: cmd: ''
    "${name}") 
      LAUNCH_CMD="${cmd} '{file.path}'" 
      ;;''
  ) platformMap);


  ######################
  ### PEGASUS THEME ####
  ######################
  #flixnet-plus = pkgs.fetchFromGitHub {
  #  owner = "ZagonAb";
  #  repo = "FlixNet_Plus";
  #  rev = "master"; # Or a specific commit hash for stability
  #  sha256 = "sha256-SzlwnuUSB5wGD7ySlFOEXtQgHeeNYwhOsoGR5DPElKg=";
  #};

  #game-os = pkgs.fetchFromGitHub {
  #  owner = "PlayingKarrde";
  #  repo = "gameOS";
  #  rev = "master"; 
  #  sha256 = "sha256-EBpIe0aw1FO7DzB6F3oAWD5FRLF2iZGtOHllMxuamdc=";
  #};

  #neoretro = pkgs.fetchFromGitHub {
  #  owner = "valsou";
  #  repo = "neoretro";
  #  rev = "master"; 
  #  sha256 = "sha256-HYL5bHvcoNrU7kFjGR7c7tc2WYKlwStiw+iBa2zHgc8=";
  #};

  #shin-retro = pkgs.fetchFromGitHub {
  #  owner = "TigraTT-Driver";
  #  repo = "shinretro";
  #  rev = "master";
  #  sha256 = "sha256-lV4xHff0ARRRyB66xNY/adoHhPsQVJ6u49bftt1PuuA=";
  #};

  minimis = pkgs.fetchFromGitHub {
    owner = "waldnercharles";
    repo = "Minimis";
    rev = "master";
    sha256 = "sha256-vi+BoNZWsnWDXF8j1uKSERrEAdYsfi9X1nSN9OYI5lA=";
  };

  #homage = pkgs.fetchFromGitHub {
  #  owner = "asdfgasfhsn";
  #  repo = "pegasus-theme-homage";
  #  rev = "master";
  #  sha256 = "sha256-G5wOFfhLBw+os49ZzDwnY0+tD1lYPp/R0mDVloVUFEw=";
  #};

  #vapour = pkgs.fetchFromGitHub {
  #  owner = "ZagonAb";
  #  repo = "Vapour-Pegasus";
  #  rev = "master";
  #  sha256 = "sha256-7AZD3w7SyLqG3qmaT9gowPe9TVHSilnXRT6sDr7IMgM=";
  #};

  #######################
  #### SCRAPE SCRIPT ####
  #######################
  scrapeScript = pkgs.writeScriptBin "scrape-games" ''
    #!/bin/sh
    PLATFORM=''${1}
    shift
    EXTRA_FLAGS="$@"
    
    # Unified path logic at the start
    if [ "$PLATFORM" = "steam" ]; then
      echo "Refreshing Steam ghost files..."
      ${steam-ghost-gen}/bin/steam-ghost-gen
      ROM_DIR="$HOME/Games/ROMs/.steam"
    else
      ROM_DIR="$HOME/Games/ROMs/$PLATFORM"
    fi
    
    SOURCE="screenscraper"
    OUT_DIR="$ROM_DIR/.metadata"

    case "$PLATFORM" in
      ${launchCase}
      *) LAUNCH_CMD="echo 'Unknown platform'; exit 1" ;;
    esac

    mkdir -p "$OUT_DIR"
    
    # --- PHASE 1: GATHERING (The "Fetch" step) ---
    # We run this first to ensure the local database (~/.skyscraper/db) is full.
    # This does not generate any files; it only downloads the raw data.
    echo "Gathering data into local cache..."
    ${pkgs.skyscraper}/bin/Skyscraper -p "$PLATFORM" \
      -s "$SOURCE" \
      -i "$ROM_DIR" \
      -u IceCubeMaker:Pokemon \
      --flags unattend,videos,manuals,fanarts,nobrackets,theinfront,backcovers \
      $EXTRA_FLAGS
      
    # Check if the platform is steam to use the hidden directory
    if [ "$PLATFORM" = "steam" ]; then
      ROM_DIR="$HOME/Games/ROMs/.steam"
    else
      ROM_DIR="$HOME/Games/ROMs/$PLATFORM"
    fi
    
    

    # --- PHASE 2: GENERATING (The "Export" step) ---
    # We keep your -e flag exactly as you have it.
    # Added -a to point to your darkened artwork rules.
    echo "Exporting metadata and applying artwork styles..."
    ${pkgs.skyscraper}/bin/Skyscraper -p "$PLATFORM" \
      -f pegasus \
      -i "$ROM_DIR" \
      -g "$OUT_DIR" \
      -o "$OUT_DIR" \
      -a /etc/skyscraper/artwork.xml \
      -e "$LAUNCH_CMD" \
      -u IceCubeMaker:Pokemon \
      --flags unattend,symlink,videos,manuals,fanarts,nobrackets,theinfront,backcovers \
      $EXTRA_FLAGS
      
      # PHASE 3: POST-PROCESS (Only for DS/3DS)
      if [ "$PLATFORM" = "nds" ] || [ "$PLATFORM" = "3ds" ]; then
        ${ds-resizer} "$OUT_DIR"
      fi
  '';
  
  ######################
  ##### SCRAPE ALL #####
  ######################
  scrapeAllScript = pkgs.writeScriptBin "scrape-all-games" ''
    #!/bin/sh
    EXTRA_FLAGS="$@"
    for sys in ${builtins.concatStringsSep " " platforms}; do
      echo "--- Starting scrape for: $sys ---"
      ${scrapeScript}/bin/scrape-games "$sys" $EXTRA_FLAGS
    done
    echo "--- All platforms finished! ---"
  '';
  
  # Helper script for DS media
  ds-resizer = pkgs.writeScript "ds-resizer" ''
    #!/bin/sh
    TARGET_DIR="$1"
    echo "Checking for DS/3DS media in $TARGET_DIR..."

    # 1. FIX SCREENSHOTS (Vertical Stack -> Side-by-Side)
    if [ -d "$TARGET_DIR/screenshot" ]; then
      for img in "$TARGET_DIR/screenshot"/*.png; do
        [ -e "$img" ] || continue
        dim=$(${pkgs.imagemagick}/bin/identify -format "%w %h" "$img")
        w=$(echo $dim | cut -d' ' -f1)
        h=$(echo $dim | cut -d' ' -f2)

        if [ "$h" -gt "$w" ]; then
          echo "Converting screenshot to side-by-side: $img"
          ${pkgs.imagemagick}/bin/magick "$img" -crop 1x2@ +append "$img"
        fi
      done
    fi
    if [ "$PLATFORM" = "nds" ] ; then
      # 2. FIX VIDEOS (Top Screen Only)
      if [ -d "$TARGET_DIR/video" ]; then
        for vid in "$TARGET_DIR/video"/*.mp4; do
          [ -e "$vid" ] || continue
          h=$(${pkgs.ffmpeg}/bin/ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=s=x:p=0 "$vid")
          
          if [ "$h" -gt 300 ]; then
            echo "Cropping video to top screen: $vid"
            ${pkgs.ffmpeg}/bin/ffmpeg -i "$vid" -filter:v "crop=iw:ih/2:0:0" -c:v libx264 -crf 20 -c:a copy -y "$vid.tmp.mp4" && mv "$vid.tmp.mp4" "$vid"
          fi
        done
      fi
    fi
  '';
  
  ####################
  ## STEAM SUPPORT ###
  ####################
  # Change this in your 'let' block
  steam-ghost-gen = pkgs.writeScriptBin "steam-ghost-gen" ''
  #!/bin/sh
  DEST="$HOME/Games/ROMs/.steam"
  mkdir -p "$DEST"

  VDF_FILE="$HOME/.local/share/Steam/steamapps/libraryfolders.vdf"

  if [ -f "$VDF_FILE" ]; then
    echo "Found Steam library configuration. Scanning all drives..."
    LIB_PATHS=$(grep "path" "$VDF_FILE" | sed 's/.*"path"[[:space:]]*"\(.*\)"/\1/')

    for LIB in $LIB_PATHS; do
      APPS_DIR="$LIB/steamapps"
      if [ -d "$APPS_DIR" ]; then
        echo "Scanning library: $APPS_DIR"
        ls "$APPS_DIR"/appmanifest_*.acf 2>/dev/null | xargs -n1 basename 2>/dev/null | \
        sed 's/appmanifest_\([0-9]*\)\.acf/\1.txt/' | \
        xargs -I{} touch "$DEST/{}"
      fi
    done
    echo "Steam ghost files updated in $DEST"
  else
    echo "Could not find libraryfolders.vdf at $VDF_FILE"
  fi
'';
in {

  # Core Gaming Environment
  ############################
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  ############################
  # Emulation Frontend
  ############################
  environment.systemPackages = with pkgs; [

    retroarch
    libretro.mgba              # GBA, GB and GBC emulator
    libretro.desmume           # DS emulation
    libretro.parallel-n64      # N64
    libretro.snes9x            # SNES 
    libretro.nestopia          # NES
    libretro.citra             # 3DS
    libretro.pcsx_rearmed      # Playstation 1
    libretro.ppsspp            # Playstation Portabl
    libretro.genesis-plus-gx   # Gensis / Megadrive, Master System
    libretro.picodrive         # Genesis, Sega CD, 32Xist
    libretro.dosbox            # DOS
    libretro.fbneo             # Neo Geo
    libretro.mame              # Arcade (MAME)
    libretro.beetle-pce-fast   # WonderSwan Colour, TurboGrafx-16
    libretro.pcsx2             # Playstation 2
    libretro.flycast           # Dreamcast
    libretro.stella            # Atari 2600

    # Launcher
    pegasus-frontend
    # Nintendo
    dolphin-emu  # GameCube/Wii
    cemu         # Wii U
    ryubing      # Switch

    # Multiplayer
    parsec-bin

    qt5.qtimageformats
    
    # Scraping Games
    imagemagick
    skyscraper
    scrapeScript
    scrapeAllScript

    # Video for pegasus launcher
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-libav
    
    # Steam setup
    steam
    steam-ghost-gen
  ];

  environment.variables.GST_PLUGIN_SYSTEM_PATH_1_0 = "/run/current-system/sw/lib/gstreamer-1.0";
  environment.variables.GST_PLUGIN_PATH_1_0 = "/run/current-system/sw/lib/gstreamer-1.0/";
  environment.variables = {
    QT_QPA_PLATFORM = "xcb"; # Forces Pegasus to use X11/XWayland
  };

  services.joycond.enable = true; # joy con support


  ############################
  # RetroArch Configuration
  ############################
  environment.etc."retroarch/retroarch.cfg".text = ''

    menu_driver = "xmb"
    savestate_auto_save = tue
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

  ############################ist
  # Controller Support
  ############################
  services.udev.packages = with pkgs; [
    # game-devices-udev-rules= "sha256-xp62i6iSjOq5p/uQe+tNNoS3vF5pB/pPshXo6I0X2+Q="; # Note: You may need to update
  ];
  

  ############################
  # Audio / Video Latency
  ############################
  hardware.graphics.enable = true;

  services.xserver.desktopManager.session = [
    {
      name = "pegasus";
      start = ''
        exec ${pkgs.pegasus-frontend}/bin/pegasus-fe
      '';
    }
  ];


  # Fix the "Unsupported image format" globally
  environment.sessionVariables = {
    QT_PLUGIN_PATH = [ "${pkgs.qt5.qtimageformats}/${pkgs.qt5.qtbase.qtPluginPrefix}" ];
  };
  
environment.etc."skyscraper/artwork.xml".text = ''<?xml version="1.0" encoding="UTF-8"?>
<artwork>
  <output type="cover" resource="cover"/>
  
  <output type="boxBack" resource="backcover">
    <draw type="backcover"/>
  </output>

  <output type="background" resource="fanart">
    <draw type="fanart">
      <brightness>-40</brightness>
      <gamma>1.3</gamma>
    </draw>
  </output>

  <output type="screenshot" resource="screenshot">
    <draw type="screenshot"><brightness>-30</brightness><gamma>1.2</gamma></draw>
  </output>

  <output type="wheel" resource="wheel"/>
  <output type="marquee" resource="marquee"/>
  <output type="banner" resource="banner"/>

  <output type="cartridge" resource="cartridge">
    <draw type="cartridge"><origin x="0.5" y="0.5"/><pos x="0.5" y="0.5"/></draw>
    <draw type="cover" cache="false" x="0.1" y="0.1" width="0.8" height="0.8"/>
  </output>
</artwork>'';

  systemd.tmpfiles.rules = [
    "d /home/franz/Games 0755 franz users -"
    "d /home/franz/Games/ROMs 0755 franz users -"
    "d /home/franz/.config/pegasus-frontend 0755 franz users -"

    # Pegasus configurations
    "f+ /home/franz/.config/pegasus-frontend/game_dirs.txt 0644 franz users -"
    "d /home/franz/.config/pegasus-frontend/themes 0755 franz users -"
    # "L+ /home/franz/.config/pegasus-frontend/themes/FlixNet_Plus - - - - ${flixnet-plus}"
    # "L+ /home/franz/.config/pegasus-frontend/themes/GameOS - - - - ${game-os}"
    # "L+ /home/franz/.config/pegasus-frontend/themes/NeoRetro - - - - ${neoretro}"
    # "L+ /home/franz/.config/pegasus-frontend/themes/ShinRetro - - - - ${shin-retro}"
    "L+ /home/franz/.config/pegasus-frontend/themes/Minimis - - - - ${minimis}"


    # Skyscraper configurations
    "L+ /home/franz/.skyscraper/artwork.xml 0644 franz users - /etc/skyscraper/artwork.xml"
  ] 
  ++ romDirRules 
  ++ pegasusRules;

  systemd.user.services.pegasus-autoscrape = {
    description = "Automatically scrape ROM metadata for Pegasus";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      # Use the script variable and loop through the platform list
      ExecStart = "${pkgs.writeShellScript "auto-scrape-task" ''
        for sys in ${builtins.concatStringsSep " " platforms}; do
          ${scrapeScript}/bin/scrape-games "$sys"
        done
      ''}";
    };
  };

  systemd.user.timers.pegasus-autoscrape = {
    description = "Run Pegasus autoscrape every day and 5 mins after boot";
    timerConfig = {
      OnBootSec = "5m";      # Run 5 minutes after you turn the PC on
      OnUnitActiveSec = "1d"; # Run once every day thereafter
    };
    wantedBy = [ "timers.target" ];
  };

}
