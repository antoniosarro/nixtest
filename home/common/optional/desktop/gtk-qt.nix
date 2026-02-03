{
  pkgs,
  lib,
  ...
}:
let
  catppuccinAccent = "Blue";
  catppuccinFlavor = "Mocha";

  catppuccinKvantum = pkgs.catppuccin-kvantum.override {
    accent = "${lib.toLower catppuccinAccent}";
    variant = "${lib.toLower catppuccinFlavor}";
  };
  qtThemeName = "catppuccin-${lib.toLower catppuccinFlavor}-${lib.toLower catppuccinAccent}";
in
{
  home.packages = with pkgs; [
    papirus-folders
    catppuccinKvantum
  ];

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-${lib.toLower catppuccinFlavor}-${lib.toLower catppuccinAccent}-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "${lib.toLower catppuccinAccent}" ];
        size = "standard";
        variant = "${lib.toLower catppuccinFlavor}";
      };
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "${lib.toLower catppuccinFlavor}";
        accent = "${lib.toLower catppuccinAccent}";
      };
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/${qtThemeName}".source = "${catppuccinKvantum}/share/Kvantum/${qtThemeName}";
    "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
      General.theme = qtThemeName;
    };
  };
}
