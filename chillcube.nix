{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    godot_4          # The latest Godot 4 engine
    git              # Version control
    github-desktop   # github GUI version
    gh               # github cli tool
    discord-ptb      # For communication
    krita            # For making art
  ];

  # Godot benefits from pipewire for low-latency audio during testing
  services.pipewire.enable = true;

  # This helps Godot find system libraries if you use C# or GDExtension
  environment.sessionVariables = {
    GODOT4_BIN = "${pkgs.godot_4}/bin/godot4";
  };

  # This ensures your dev folder is ready the moment you log in
  systemd.tmpfiles.rules = [
    "d /home/franz/Dev 0755 franz users -"
    "d /home/franz/Dev/Libraries 0755 franz users -"
    "d /home/franz/Dev/Projects 0755 franz users -"
   ];

   # Ensure the Secret Service is available
   services.gnome.gnome-keyring.enable = true;
   
   # to make sure godot can load the asset library
   environment.sessionVariables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
   };

   # Add the specific GNOME portal
   xdg.portal = {
     enable = true;
     extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
   };

  systemd.services.sync-chillcube = {
    description = "Pull the latest ChillCube library";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "local-fs.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "franz";
      Group = "users";
      # This is the magic line: it tells systemd to allow full access to /home/franz
      ProtectHome = false;
      # Ensures the script has a basic environment
      Environment = "PATH=${pkgs.git}/bin:${pkgs.coreutils}/bin";
      RemainAfterExit = true;
    };
    
    script = ''
      # Ensure the path exists manually just in case
      mkdir -p /home/franz/Dev/Libraries/ChillCube
      DEST="/home/franz/Dev/Libraries/ChillCube"
      
      if [ ! -d "$DEST/.git" ]; then
        rm -rf "$DEST"
        git clone https://github.com/IceCubeMaker/ChillCube_GodotLibrary "$DEST"
      else
        cd "$DEST"
        git pull origin main
      fi
    '';

  };

}
