{
  wayland.windowManager.hyprland.settings = {
    env = [
      # Terminal
      "TERMINAL,kitty"

      # Cursor
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
      "HYPRCURSOR_THEME,rose-pine-hyprcursor"

      # XDG
      "XDG_SESSION_TYPE,wayland"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"

      # Intel Graphics (Tiger Lake specific)
      "LIBVA_DRIVER_NAME,iHD"
      "MESA_LOADER_DRIVER_OVERRIDE,iris"
      "VDPAU_DRIVER,va_gl"

      # Qt
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_STYLE_OVERRIDE,kvantum"

      # GDK
      "GDK_BACKEND,wayland,x11,*"

      # Force Wayland
      "SDL_VIDEODRIVER,wayland"
      "OZONE_PLATFORM,wayland"
      "NIXOS_OZONE_WL,1"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"

      # Firefox
      "MOZ_ENABLE_WAYLAND,1"
      "MOZ_WEBRENDER,1"

      # XCompose
      "XCOMPOSEFILE,~/.XCompose"
    ];

    xwayland = {
      force_zero_scaling = false;
    };

    ecosystem = {
      no_update_news = true;
    };
  };
}
