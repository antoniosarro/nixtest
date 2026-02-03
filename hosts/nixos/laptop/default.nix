{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = lib.flatten [
    # ============================
    # Hardware
    # ============================
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    # ============================
    # Disk Layout
    # ============================
    inputs.disko.nixosModules.disko
    (lib.custom.relativeToRoot "hosts/common/disks/laptop.nix")
    {
      _module.args = {
        disk = "/dev/nvme0n1";
        withSwap = true;
        swapSize = 16;
      };
    }

    # ============================
    # Modules
    # ============================
    (map lib.custom.relativeToRoot (
      # Required modules
      [
        "hosts/common/core"
      ]
      ++
        # Optional modules
        (map (f: "hosts/common/optional/${f}") [
          # Services
          "services/bluetooth.nix"
          "services/sddm.nix"

          # Misc
          "audio.nix"
          "fonts.nix"
          "gpu.nix"
          "hyprland.nix"
          "plymouth.nix"
          "thunar.nix"
          "uwsm.nix"
        ])
    ))
  ];

  # ============================
  # Host Specification
  # ============================
  hostSpec = {
    hostName = "laptop";
    primaryUsername = lib.mkForce "antoniosarro";
    persistFolder = "/persist";

    # System type flags
    isRemote = lib.mkForce false;
    isRoaming = lib.mkForce true;

    # Functionality
    useYubikey = lib.mkForce false;

    # Graphical
    theme = lib.mkForce "darcula";
    wallpaper = "${inputs.nix-assets}/images/wallpapers/zen-02.jpg";
    isAutoStyled = lib.mkForce true;
    hdr = lib.mkForce true;
  };

  # ============================
  # Network
  # ============================
  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };
  wifi = {
    enable = true;
    roaming = config.hostSpec.isRoaming;
  };

  services.fwupd.enable = true;

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = lib.mkDefault 10;
      consoleMode = "max";
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.initrd = {
    systemd.enable = true;
    kernelModules = [
    ];
  };

  boot.kernelParams = [
    # Better power management for Tiger Lake
    "i915.enable_psr=1"
    "i915.enable_fbc=1"
  ];

  system.stateVersion = "25.11";
}
