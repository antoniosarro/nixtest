{ pkgs, ... }:
{
  imports = [
    ./spotify
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      ;
  };
}
