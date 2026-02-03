{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "suppressevent maximize, class:.*"
      "opacity 0.97 0.9, class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

      # Bitwarden
      "noscreenshare, class:^(Bitwarden)$"

      # Browsers
      "tag +chromium-based-browser, class:([cC]hrom(e|ium)|[bB]rave-browser|Microsoft-edge|Vivaldi-stable)"
      "tag +firefox-based-browser, class:([fF]irefox|zen|librewolf)"

      # Force chromium-based browsers into a tile to deal with --app bug
      "tile, tag:chromium-based-browser"

      # Only a subtle opacity change, but not for video sites
      "opacity 1 0.97, tag:chromium-based-browser"
      "opacity 1 0.97, tag:firefox-based-browser"

      # Some video sites should never have opacity applied to them
      "opacity 1.0 1.0, initialTitle:((?i)(?:[a-z0-9-]+\.)*youtube\.com_/|app\.zoom\.us_/wc/home)"

      # Float LocalSend and fzf file picker
      "float, class:(Share|localsend)"
      "center, class:(Share|localsend)"

      # Picture-in-picture overlays
      "tag +pip, title:(Picture.{0,1}in.{0,1}[Pp]icture)"
      "float, tag:pip"
      "pin, tag:pip"
      "size 600 338, tag:pip"
      "keepaspectratio, tag:pip"
      "noborder, tag:pip"
      "opacity 1 1, tag:pip"
      "move 100%-w-40 4%, tag:pip"

      # Qemu
      "opacity 1 1, class:qemu"

      # Steam
      "float, class:steam"
      "center, class:steam, title:Steam"
      "opacity 1 1, class:steam"
      "size 1100 700, class:steam, title:Steam"
      "size 460 800, class:steam, title:Friends List"
      "idleinhibit fullscreen, class:steam"

      # Floating windows
      "float, tag:floating-window"
      "center, tag:floating-window"
      "size 800 600, tag:floating-window"

      "tag +floating-window, class:(blueberry.py|Impala|Wiremix|com.gabm.satty|About)"
      "tag +floating-window, class:(xdg-desktop-portal-hyprland|DesktopEditors), title:^(Open.*Files?|Open Folder|Save.*Files?|Save.*As|Save|All Files)"

      # Fullscreen screensaver
      "fullscreen, class:Screensaver"

      # No transparency on media windows
      "opacity 1 1, class:^(mpv|com.obsproject.Studio|imv)$"

      # Define terminal tag to style them uniformly
      "tag +terminal, class:(Alacritty|kitty|com.mitchellh.ghostty)"

      # Scroll faster in the terminal
      "scrolltouchpad 1.5, tag:terminal"
    ];

    layerrule = [
      # Remove 1px border around hyprshot screenshots
      "noanim, selection"

      # Application-specific animation
      "noanim, rofi"
    ];
  };
}
