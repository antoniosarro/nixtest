{
  config,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    workspace = (
      let
        workspaceIDs = lib.flatten [
          (lib.range 1 10)
          "special"
        ];
        isPrimary = x: x ? primary && x.primary;
        primary = lib.lists.findFirst isPrimary { } config.monitors;
      in
      # workspace structure "[workspace], monitor:[name], default:[bool], persistent:[bool]"
      map (
        id:
        let
          id_as_string = toString id;
          # determine if the monitor is intended to display a specific workspace
          monitor = lib.lists.findFirst (
            x: x ? "workspace" && id_as_string == x.workspace
          ) primary config.monitors;
          # workspace 1 and any workspaces specific to the non-primary monitors are persistent
          persistent = if (id == 1 || !(isPrimary monitor)) then ", persistent:true" else "";
        in
        "${id_as_string}, monitor:${monitor.name}, default:true" + persistent
      ) workspaceIDs
    );
  };
}
