{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.enableAllTerminfo = true;
  hardware.enableRedistributableFirmware = true;

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  security.sudo.extraConfig = ''
    Defaults lecture = never # rollback results in sudo lectures after each reboot, it's somewhat useless anyway
    Defaults pwfeedback # password input feedback - makes typed password visible as asterisks
    Defaults timestamp_timeout=120 # only ask for password every 2h
    # Keep SSH_AUTH_SOCK so that pam_ssh_agent_auth.so can do its magic.
    Defaults env_keep+=SSH_AUTH_SOCK
  '';

  services.displayManager = lib.optionalAttrs config.hostSpec.useWindowManager {
    autoLogin.enable = false;
    autoLogin.user = config.hostSpec.primaryDesktopUsername;
    defaultSession = config.hostSpec.defaultDesktop;
  };

  # ============================
  # Generation Pinning
  # ============================
  boot.loader.systemd-boot.extraEntries =
    let
      pinned = lib.custom.relativeToRoot "hosts/nixos/${config.hostSpec.hostName}/pinned-boot-entry.conf";
    in
    lib.optionalAttrs (config.boot.loader.systemd-boot.enable && builtins.pathExists pinned) {
      "pinned-stable.conf" = builtins.readFile pinned;
    };

  environment = {
    localBinInPath = true;

    etc."xdg/user-dirs.defaults".text = ''
      DOWNLOAD=downloads
      TEMPLATES=tmp
      PUBLICSHARE=/var/empty
      DOCUMENTS=doc
      MUSIC=media/audio
      PICTURES=media/images
      VIDEOS=media/video
      DESKTOP=.desktop
    '';
  };

  # ============================
  # Nix Helper
  # ============================
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 20d --keep 20";
    flake = "${config.hostSpec.home}/nixdots";
  };

  # ============================
  # Localization
  # ============================
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  time.timeZone = lib.mkDefault config.hostSpec.timeZone;

}
