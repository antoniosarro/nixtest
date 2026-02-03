{
  pkgs,
  ...
}:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = (
      builtins.attrValues {
        inherit (pkgs)
          noto-fonts
          source-sans
          source-serif

          # icon fonts
          material-design-icons
          font-awesome

          # for work
          montserrat
          vista-fonts
          ;
        inherit (pkgs.unstable.nerd-fonts)
          fira-mono
          iosevka
          jetbrains-mono
          symbols-only
          ;
      }
    );
    fontconfig.defaultFonts = {
      serif = [
        "Iosevka Nerd Font Mono"
        "Nerd Fonts Symbols Only"
      ];
      sansSerif = [
        "FiraMono Nerd Font Mono"
        "Nerd Fonts Symbols Only"
      ];
      monospace = [
        "FiraMono Nerd Font Mono"
        "JetBrainsMono Nerd Font"
        "Iosevka Nerd Font Mono"
        "Nerd Fonts Symbols Only"
      ];
      emoji = [
        "Nerd Fonts Symbols Only"
      ];
    };
  };
}
