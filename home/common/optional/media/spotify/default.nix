{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "spotify" ];
  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.text;

    # colorScheme = "custom";
    # customColorScheme = {
    #   accent = config.hostSpec.theme.colors.base0B;
    #   accent-active = config.hostSpec.theme.colors.base0B;
    #   accent-inactive = config.hostSpec.theme.colors.base00;
    #   banner = config.hostSpec.theme.colors.base0B;
    #   border-active = config.hostSpec.theme.colors.base0B;
    #   border-inactive = config.hostSpec.theme.colors.base02;
    #   header = config.hostSpec.theme.colors.base04;
    #   highlight = config.hostSpec.theme.colors.base04;
    #   main = config.hostSpec.theme.colors.base00;
    #   notification = config.hostSpec.theme.colors.base0D;
    #   notification-error = config.hostSpec.theme.colors.base08;
    #   subtext = "a6adc8";
    #   text = config.hostSpec.theme.colors.base05;
    # };

    enabledExtensions = with spicePkgs.extensions; [
      autoSkipVideo
      fullAppDisplay
      playlistIcons
      fullAlbumDate
      skipStats
      songStats
      autoVolume
      history
      betterGenres
      hidePodcasts
      adblock
    ];
  };
}
