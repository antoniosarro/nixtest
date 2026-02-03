{ config, ... }:
{
  systemd.user.services.waybar = {
    Unit = {
      StartLimitInterval = 0;
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
  };

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 26;
        modules-left = [
          "custom/nixdots"
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
          "custom/screenrecording-indicator"
        ];
        modules-right = [
          "group/tray-expander"
          "bluetooth"
          "network"
          "pulseaudio"
          "cpu"
        ];

        # ============================
        # Module Left
        # ============================
        "custom/nixdots" = {
          "format" = "<span>\ue843</span>";
          "on-click" = "nixdots-menu";
          "tooltip-format" = "Omarchy Menu\n\nSuper + Alt + Space";
        };

        "hyprland/workspaces" = {
          "on-click" = "activate";
          "format" = "{icon}";
          "format-icons" = {
            "default" = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "active" = "󱓻";
          };
          "persistent-workspaces" = {
            "1" = "[]";
            "2" = "[]";
            "3" = "[]";
            "4" = "[]";
            "5" = "[]";
          };
        };

        # ============================
        # Module Center
        # ============================
        "clock" = {
          "format" = "{:L%A %H:%M}";
          "format-alt" = "{:L%d %B W%V %Y}";
          "tooltip" = false;
          "on-click-right" = "nixdots-cmd-tzupdate";
        };

        "custom/screenrecording-indicator" = {
          "on-click" = "nixdots-cmd-screenrecord";
          "signal" = 8;
          "return-type" = "json";
          "exec" = "nixdots-waybar-screen-recording";
        };

        # ============================
        # Module Right
        # ============================
        "group/tray-expander" = {
          "orientation" = "inherit";
          "drawer" = {
            "transition-duration" = 600;
            "children-class" = "tray-group-item";
          };
          "modules" = [
            "custom/expand-icon"
            "tray"
          ];
        };
        "custom/expand-icon" = {
          "format" = " ";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 12;
          "spacing" = 12;
        };

        "bluetooth" = {
          "format" = "";
          "format-disabled" = "󰂲";
          "format-connected" = "";
          "tooltip-format" = "Devices connected: {num_connections}";
          "on-click" = "blueberry";
        };

        "network" = {
          "format-icons" = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          "format" = "{icon}";
          "format-wifi" = "{icon}";
          "format-ethernet" = "󰀂";
          "format-disconnected" = "󰤮";
          "tooltip-format-wifi" = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          "tooltip-format-ethernet" = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          "tooltip-format-disconnected" = "Disconnected";
          "interval" = 3;
          "spacing" = 1;
          "on-click" = "nixdots-launch-wifi";
        };

        "pulseaudio" = {
          "format" = "{icon}";
          "on-click" = "$TERMINAL --class=Wiremix -e wiremix";
          "on-click-right" = "pamixer -t";
          "tooltip-format" = "Playing at {volume}%";
          "scroll-step" = 5;
          "format-muted" = "";
          "format-icons" = {
            "default" = [
              ""
              ""
              ""
            ];
          };
        };

        "cpu" = {
          "interval" = 5;
          "format" = "󰍛";
          "on-click" = "$TERMINAL -e btop";
        };
      };
    };

    style = ''
      @define-color foreground #8a8a8d;
      @define-color background #1e1e1e;

      * {
        background-color: @background;
        color: @foreground;

        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: JetBrainsMono Nerd Font;
        font-size: 12px;
      }

      .modules-left {
        margin-left: 8px;
      }

      .modules-right {
        margin-right: 8px;
      }

      #workspaces button {
        all: initial;
        padding: 0 6px;
        margin: 0 1.5px;
        min-width: 9px;
      }

      #workspaces button.empty {
        opacity: 0.5;
      }

      #tray,
      #cpu,
      #network,
      #bluetooth,
      #pulseaudio,
      #custom-nixdots,
      #custom-screenrecording-indicator{
        min-width: 12px;
        margin: 0 7.5px;
      }

      #custom-expand-icon {
        margin-right: 7px;
      }

      tooltip {
        padding: 2px;
      }

      #clock {
        margin-left: 8.75px;
      }

      .hidden {
        opacity: 0;
      }

      #custom-screenrecording-indicator {
        min-width: 12px;
        margin-left: 8.75px;
        font-size: 10px;
      }

      #custom-screenrecording-indicator.active {
        color: #a55555;
      }
    '';
  };
}
