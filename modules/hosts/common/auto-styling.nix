{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  # Also see modules/home/auto-styling.nix
  config = lib.mkIf config.hostSpec.isAutoStyled {
    stylix = {

    };
  };
}
