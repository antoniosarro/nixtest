{ lib, config, ... }:
{
  imports = (
    map lib.custom.relativeToRoot (
      [
        # ============================
        # Hardware Required Configs
        # ============================
        "home/common/core"
        "home/common/core/nixos.nix"

        "home/antoniosarro/common/nixos.nix"
      ]
      ++
        # ============================
        # Host-specific Configs
        # ============================
        (map (f: "home/common/optional/${f}") [
          "browsers"
          "comms"
          "desktop"
          "development"
          "media"
          "scripts"
          "tools"
        ])
    )
  );

  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      primary = true;
    }
  ];

  home.file."${config.home.homeDirectory}/media/images/wallpapers" = {
    recursive = true;
    source = lib.custom.relativeToRoot "wallpapers";
  };
}
