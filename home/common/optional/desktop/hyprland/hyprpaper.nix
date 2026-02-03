{ config, lib, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${config.home.homeDirectory}/media/images/wallpapers/1.jpg" ];
      wallpaper = [ ",${config.home.homeDirectory}/media/images/wallpapers/1.jpg" ];
    };
  };
  systemd.user.services.hyprpaper.Unit.After = lib.mkForce [ "graphical-session.target" ];
}
