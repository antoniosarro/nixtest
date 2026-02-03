{
  pkgs,
  config,
  ...
}:
{
  programs.uwsm = {
    enable = true;
    package = pkgs.unstable.uwsm;
    waylandCompositors.hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor";
      binPath = "${config.programs.hyprland.package}/bin/Hyprland";
    };
  };
}
