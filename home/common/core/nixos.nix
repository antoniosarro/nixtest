{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [

  ];

  home = {
    packages = lib.optionals (config.hostSpec.isProduction) (
      builtins.attrValues {
        inherit (pkgs)
          ;
      }
    );

    activation.reloadFontCache = lib.hm.dag.entryAfter [ "linkActivation" ] ''
      if [ -x "${pkgs.fontconfig}/bin/fc-cache" ]; then
        ${pkgs.fontconfig}/bin/fc-cache -f
      fi
    '';

    sessionVariables = {

    }
    // lib.optionalAttrs config.hostSpec.useWayland {
      QT_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      CLUTTER_BACKEND = "wayland"; # for gnome-shell
      SDL_VIDEODRIVER = "wayland"; # for SDL apps
      NIXOS_OZONE_WL = "1"; # for chromium, vscode, electron, etc
      XDG_SESSION_TYPE = "wayland";
      MOZ_ENABLE_WAYLAND = "1";

    };
  };

  services.ssh-agent.enable = true;
}
