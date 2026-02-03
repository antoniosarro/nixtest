{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      default-timeout = 5000;
      width = 420;
      height = 110;
    };
  };
  home.packages = with pkgs; [
    libnotify # provides notify-send
    mako # notification daemon
  ];
}
