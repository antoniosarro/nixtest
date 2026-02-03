{
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = [ pkgs.adi1090x-plymouth-themes ];
  boot = {
    kernelParams = [
      "quiet"
    ];
    plymouth = {
      enable = true;
      theme = lib.mkForce "deus_ex";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "deus_ex" ]; })
      ];
    };
    consoleLogLevel = 0;
  };
}
