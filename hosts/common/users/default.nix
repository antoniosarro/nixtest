{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  hostSpec = config.hostSpec;

  pubKeys = lib.filesystem.listFilesRecursive (
    lib.custom.relativeToRoot "hosts/common/users/${hostSpec.primaryUsername}/keys/"
  );

  primaryUserPubKeys = lib.lists.forEach pubKeys (key: builtins.readFile key);
in
{
  programs.zsh.enable = true;
  programs.git.enable = true;
  environment = {
    systemPackages = [
      pkgs.just
    ];
  };

  users = {
    users =
      (lib.mergeAttrsList (
        map (user: {
          "${user}" =
            let
              platformPath = lib.custom.relativeToRoot "hosts/common/users/${user}/nixos.nix";
            in
            {
              name = user;
              shell = pkgs.zsh;
              openssh.authorizedKeys.keys = primaryUserPubKeys;
              home = "/home/${user}";
              hashedPassword = "$y$j9T$fWn4.HzmsT7aryHo34PfC.$wlH3KX5.fdTztxgS8kYNCOTqD1RcebdP0S6q1Z4kT77";
            }
            // lib.optionalAttrs (lib.pathExists platformPath) (
              import platformPath {
                inherit config lib;
              }
            );
        }) config.hostSpec.users
      ))
      // {
        root = {
          shell = pkgs.zsh;
          hashedPassword = "$y$j9T$fWn4.HzmsT7aryHo34PfC.$wlH3KX5.fdTztxgS8kYNCOTqD1RcebdP0S6q1Z4kT77";
          openssh.authorizedKeys.keys =
            config.users.users.${config.hostSpec.primaryUsername}.openssh.authorizedKeys.keys;
        };
      };
  }
  // {
    mutableUsers = false;
  };
}
// lib.optionalAttrs (inputs ? "home-manager") {
  home-manager =
    let
      fullPathIfExists =
        path:
        let
          fullPath = lib.custom.relativeToRoot path;
        in
        lib.optional (lib.pathExists fullPath) fullPath;
    in
    {
      extraSpecialArgs = {
        inherit pkgs inputs;
        hostSpec = config.hostSpec;
        monitors = config.monitors;
      };

      users =
        (lib.mergeAttrsList (
          map (user: {
            "${user}".imports = lib.flatten [
              (lib.optional (!hostSpec.isMinimal) (
                map (fullPathIfExists) [
                  "home/${user}/${hostSpec.hostName}.nix"
                  "home/${user}/common"
                  "home/${user}/common/nixos.nix"
                ]
              ))
              (
                { ... }:
                {
                  home = {
                    homeDirectory = "/home/${user}";
                    username = "${user}";
                  };
                }
              )
            ];
          }) config.hostSpec.users
        ))
        // {
          root = {
            home.stateVersion = "25.05";
            programs.zsh.enable = true;
            programs.starship = {
              enable = true;
              package = pkgs.unstable.starship;
            };
          };
        };
    };
}
