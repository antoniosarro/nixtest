{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      # Development
      vscodium-fhs
      sqlitebrowser
      vscode
      insomnia
      rustup
      # Device Imaging
      # Productivity
      qbittorrent
      copyq
      drawio
      libreoffice
      obsidian
      # Security
      bitwarden
      # Media
      freetube
      # VM
      remmina
      # Other
      android-file-transfer
      localsend
      rpi-imager
      nvd
      # orca-slicer
      orca-slicer
      freecad-wayland
      ;
  };
}
