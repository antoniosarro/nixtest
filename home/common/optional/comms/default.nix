{ pkgs, ... }:
{
  imports = [
    ./vesktop
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)

      ;

    inherit (pkgs.unstable)
      teams-for-linux
      telegram-desktop
      ;
  };
}
