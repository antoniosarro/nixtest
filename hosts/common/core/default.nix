{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
    { programs.nix-index-database.comma.enable = true; }

    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/hosts/common"
      "modules/hosts/nixos"

      "hosts/common/core/nixos.nix"

      "hosts/common/users/"
    ])
  ];

  # ============================
  # Core Host Specifications
  # ============================
  hostSpec = {
    primaryUsername = "antoniosarro";
    username = "antoniosarro";
    users = [ "antoniosarro" ];
    handle = "antoniosarro";
    email = {
      github = "contact@antoniosarro.dev";
    };
  };

  networking.hostName = config.hostSpec.hostName;

  environment.systemPackages = [ pkgs.openssh ];

  home-manager.backupFileExtension = "bk";

  # ============================
  # Overlays
  # ============================
  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  # ============================
  # Basic Shell
  # ============================
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
}
