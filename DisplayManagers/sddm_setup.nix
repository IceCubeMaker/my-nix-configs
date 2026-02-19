{ pkgs, lib, ... }:

{
  # Enable SDDM with the Astronaut Theme
  services.displayManager.sddm = {
    enable = true;
    # Use mkForce to resolve the conflict with Plasma 6's default definition
    package = lib.mkForce pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    wayland.enable = true;
  };

  # Provide the theme and its dependencies
  # These are required for the QML engine to render the theme correctly
  services.displayManager.sddm.extraPackages = [
    pkgs.sddm-astronaut
    pkgs.kdePackages.qtsvg
    pkgs.kdePackages.qtmultimedia
    pkgs.kdePackages.qtvirtualkeyboard
  ];

  # Fix the "defaultSession" warning from your configuration.nix
  # Ensure this is updated in your main configuration.nix as well!
  services.displayManager.defaultSession = "plasma"; # or "gnome", "hyprland", etc.

  # Optional: Theme customization
  # This allows you to pick a specific sub-theme (e.g., "mountain", "ghost", "astronaut")
  environment.systemPackages = [
    (pkgs.sddm-astronaut.override {
      embeddedTheme = "astronaut"; 
    })
  ];
}
