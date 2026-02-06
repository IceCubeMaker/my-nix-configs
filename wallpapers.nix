{ pkgs, ... }:

let
  # This downloads the image
  wall1 = pkgs.fetchurl {
    url = "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe";
    sha256 = "sha256-7p0U8q6D7rXyNf9WzV4uX9vK6fH8O0LzZ4B9Q6S3mE=";
  };
in
{
  # This creates a folder in /run/current-system/sw/share/wallpapers
  # which is visible and accessible to all users.
  environment.systemPackages = [
    (pkgs.runCommand "my-wallpapers" {} ''
      mkdir -p $out/share/wallpapers
      cp ${wall1} $out/share/wallpapers/abstract-blue.jpg
    '')
  ];
}
