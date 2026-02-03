{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./chromium.nix
    ./firefox.nix
    ./zen.nix
  ];
}
