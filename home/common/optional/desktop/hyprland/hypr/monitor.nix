{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = (
      map (
        m:
        "${m.name},${
          if m.enabled then
            "${toString m.width}x${toString m.height}@${toString m.refreshRate},${toString m.x}x${toString m.y},1,transform,${toString m.transform},vrr,${toString m.vrr}"
          else
            "disable"
        }"
      ) (config.monitors)
    );
  };
}
