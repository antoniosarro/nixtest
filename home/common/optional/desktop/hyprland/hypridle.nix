{ config, lib, ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "nixdots-lock-screen";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        inhibit_sleep = 3;
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "pidof hyprlock || nixdots-launch-screensaver";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
  systemd.user.services.hyprpaper.Unit.After = lib.mkForce [ "graphical-session.target" ];
}
