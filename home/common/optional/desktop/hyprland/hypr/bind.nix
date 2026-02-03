{ pkgs, ... }:
let
  terminal = "uwsm-app -- xdg-terminal-exec";
  browser = "nixdots-launch-browser";
  osdclient = ''swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"'';
in
{
  wayland.windowManager.hyprland.settings = {
    # ============================
    # Main Key
    # ============================
    "$mainMod" = "SUPER";

    bindeld = [
      # Laptop multimedia keys for volume and LCD brightness (with OSD)
      ",XF86AudioRaiseVolume, Volume up, exec, ${osdclient} --output-volume raise"
      ",XF86AudioLowerVolume, Volume down, exec, ${osdclient} --output-volume lower"
      ",XF86AudioMute, Mute, exec, ${osdclient} --output-volume mute-toggle"
      ",XF86AudioMicMute, Mute microphone, exec, ${osdclient} --input-volume mute-toggle"
      ",XF86MonBrightnessUp, Brightness up, exec, ${osdclient} --brightness raise"
      ",XF86MonBrightnessDown, Brightness down, exec, ${osdclient} --brightness lower"

      # Precise 1% multimedia adjustments with Alt modifier
      "ALT, XF86AudioRaiseVolume, Volume up precise, exec, ${osdclient} --output-volume +1"
      "ALT, XF86AudioLowerVolume, Volume down precise, exec, ${osdclient} --output-volume -1"
      "ALT, XF86MonBrightnessUp, Brightness up precise, exec, ${osdclient} --brightness +1"
      "ALT, XF86MonBrightnessDown, Brightness down precise, exec, ${osdclient} --brightness -1"

      # Requires playerctl
      ",XF86AudioNext, Next track, exec, ${osdclient} --playerctl next"
      ",XF86AudioPause, Pause, exec, ${osdclient} --playerctl play-pause"
      ",XF86AudioPlay, Play, exec, ${osdclient} --playerctl play-pause"
      ",XF86AudioPrev, Previous track, exec, ${osdclient} --playerctl previous"
    ];

    bindld = [
      # Switch audio output with Super + Mute
      "SUPER, XF86AudioMute, Switch audio output, exec, nixdots-cmd-audio-switch"
    ];

    bindd = [
      "SUPER, Return, Terminal, exec, ${terminal}"
      "SUPER, F, File manager, exec, uwsm-app -- thunar --window"
      "SUPER, B, Browser, exec, ${browser}"
      "SUPER SHIFT, B, Browser (private), exec, ${browser} --private"
      "SUPER, M, Music, exec, nixdots-launch-or-focus spotify"
      "SUPER, N, Editor, exec, nixdots-launch-editor"
      "SUPER, T, Activity, exec, ${terminal} -e btop"
      "SUPER, D, Docker, exec, ${terminal} -e lazydocker"
      ''SUPER, G, Signal, exec, nixdots-launch-or-focus signal "uwsm-app -- signal-desktop"''
      ''SUPER, O, Obsidian, exec, nixdots-launch-or-focus "^obsidian$" "uwsm-app -- obsidian -disable-gpu --enable-wayland-ime"''
      "SUPER, SLASH, Passwords, exec, uwsm-app -- bitwarden"

      # Menus
      "SUPER, SPACE, Launch apps, exec, rofi -show drun"
      "SUPER CTRL, E, Emoji picker, exec, rofi -modi emoji -show emoji"
      "SUPER ALT, SPACE, Nixdots menu, exec, nixdots-menu"
      "SUPER, ESCAPE, Power menu, exec, nixdots-menu system"
      ", XF86PowerOff, Power menu, exec, nixdots-menu system"
      "SUPER, K, Show key bindings, exec, nixdots-menu-keybindings"

      # Aesthetics
      "SUPER SHIFT, SPACE, Toggle top bar, exec, nixdots-toggle-waybar"
      ''SUPER, BACKSPACE, Toggle window transparency, exec, hyprctl dispatch setprop "address:$(hyprctl activewindow -j | jq -r '.address')" opaque toggle''

      # Notifications
      "SUPER, COMMA, Dismiss last notification, exec, makoctl dismiss"
      "SUPER SHIFT, COMMA, Dismiss all notifications, exec, makoctl dismiss --all"
      ''SUPER CTRL, COMMA, Toggle silencing notifications, exec, makoctl mode -t do-not-disturb && makoctl mode | grep -q 'do-not-disturb' && notify-send "Silenced notifications" || notify-send "Enabled notifications"''

      # Toggle idling
      "SUPER CTRL, I, Toggle locking on idle, exec, nixdots-toggle-idle"

      # Toggle nightlight
      "SUPER CTRL, N, Toggle nightlight, exec, nixdots-toggle-nightlight"

      # Screenshots
      ", PRINT, Screenshot with editing, exec, nixdots-cmd-screenshot"
      "SHIFT, PRINT, Screenshot to clipboard, exec, nixdots-cmd-screenshot smart clipboard"

      # Screen recordings
      "ALT, PRINT, Screenrecording, exec, nixdots-cmd-screenrecord"

      # Color picker
      "SUPER, PRINT, Color picker, exec, pkill hyprpicker || hyprpicker -a"

      # File sharing
      "CTRL SUPER, S, Share, exec, nixdots-menu share"

      # Waybar-less information
      ''SUPER CTRL, T, Show time, exec, sh -c 'notify-send "🕐    $(date +"%A %H:%M  —  %d %B W%V %Y")"' ''
      ''SUPER CTRL, B, Show battery remaining, exec, sh -c 'notify-send "󰁹    Battery is at $(nixdots-battery-remaining)%"' ''

      # Close windows
      "SUPER, W, Close active window, killactive"
      "CTRL ALT, DELETE, Close all Windows, exec, nixdots-hyprland-close-all-windows"

      # Control tiling
      "SUPER, J, Toggle split, togglesplit" # dwindle
      "SUPER, P, Pseudo window, pseudo" # dwindle
      "SUPER, V, Toggle floating, togglefloating"
      "SHIFT, F11, Force full screen, fullscreen, 0"
      "ALT, F11, Full width, fullscreen, 1"

      # Move focus with SUPER + arrow keys
      "SUPER, left, Move focus left, movefocus, l"
      "SUPER, right, Move focus right, movefocus, r"
      "SUPER, up, Move focus up, movefocus, u"
      "SUPER, down, Move focus down, movefocus, d"

      # Tab between workspaces
      "SUPER, TAB, Next workspace, workspace, e+1"
      "SUPER SHIFT, TAB, Previous workspace, workspace, e-1"
      "SUPER CTRL, TAB, Former workspace, workspace, previous"

      # Swap active window with the one next to it with SUPER + SHIFT + arrow keys
      "SUPER SHIFT, left, Swap window to the left, swapwindow, l"
      "SUPER SHIFT, right, Swap window to the right, swapwindow, r"
      "SUPER SHIFT, up, Swap window up, swapwindow, u"
      "SUPER SHIFT, down, Swap window down, swapwindow, d"

      # Cycle through applications on active workspace
      "ALT, Tab, Cycle to next window, cyclenext"
      "ALT SHIFT, Tab, Cycle to prev window, cyclenext, prev"
      "ALT, Tab, Reveal active window on top, bringactivetotop"
      "ALT SHIFT, Tab, Reveal active window on top, bringactivetotop"

      # Resize active window
      "SUPER, code:20, Expand window left, resizeactive, -100 0"
      "SUPER, code:21, Shrink window left, resizeactive, 100 0"
      "SUPER SHIFT, code:20, Shrink window up, resizeactive, 0 -100"
      "SUPER SHIFT, code:21, Expand window down, resizeactive, 0 100"

      # Scroll through existing workspaces with SUPER + scroll
      "SUPER, mouse_down, Scroll active workspace forward, workspace, e+1"
      "SUPER, mouse_up, Scroll active workspace backward, workspace, e-1"
    ]
    # Dynamically generate workspace switching keybinds (SUPER + [1-0])
    ++ (builtins.genList (
      i:
      let
        ws = i + 1;
        keycode = toString (9 + ws); # code:10 through code:19
      in
      "SUPER, code:${keycode}, Switch to workspace ${toString ws}, workspace, ${toString ws}"
    ) 10)
    # Dynamically generate move to workspace keybinds (SUPER + SHIFT + [1-0])
    ++ (builtins.genList (
      i:
      let
        ws = i + 1;
        keycode = toString (9 + ws); # code:10 through code:19
      in
      "SUPER SHIFT, code:${keycode}, Move window to workspace ${toString ws}, movetoworkspace, ${toString ws}"
    ) 10);

    bindmd = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "SUPER, mouse:272, Move window, movewindow"
      "SUPER, mouse:273, Resize window, resizewindow"
    ];
  };

  home.packages = with pkgs; [
    swayosd
    jq
    playerctl
    hyprpicker
  ];
}
