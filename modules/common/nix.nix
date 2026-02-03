{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };

  nix = {
    package = lib.mkForce pkgs.unstable.nixVersions.nix_2_30;
    settings = {
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000;
      max-free = 1000000000;
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      warn-dirty = false;
      allow-import-from-derivation = true;
      trusted-users = [ "@wheel" ];
      builders-use-substitutes = true;
      fallback = true;
      substituters = [
        "https://cache.nixos.org" # Official global cache
        "https://nix-community.cachix.org" # Community packages
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  }
  // (lib.optionalAttrs pkgs.stdenv.isLinux {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  });
}
