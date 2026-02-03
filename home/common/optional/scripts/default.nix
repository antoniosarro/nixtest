{ pkgs, ... }:
let
  nixdots-battery-remaining = pkgs.writeShellApplication {
    name = "nixdots-battery-remaining";
    runtimeInputs = [
    ];
    text = builtins.readFile ./nixdots-battery-remaining;
  };
  nixdots-cmd-audio-switch = pkgs.writeShellApplication {
    name = "nixdots-cmd-audio-switch";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-cmd-audio-switch;
  };
  nixdots-cmd-present = pkgs.writeShellApplication {
    name = "nixdots-cmd-present";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-cmd-present;
  };
  nixdots-cmd-screenrecord = pkgs.writeShellApplication {
    name = "nixdots-cmd-screenrecord";
    runtimeInputs = [
      pkgs.slurp
      pkgs.unstable.v4l-utils
      pkgs.ffmpeg
      pkgs.unstable.gpu-screen-recorder
    ];
    text = builtins.readFile ./nixdots-cmd-screenrecord;
  };
  nixdots-cmd-screenshot = pkgs.writeShellApplication {
    name = "nixdots-cmd-screenshot";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-cmd-screenshot;
  };
  nixdots-hyprland-close-all-windows = pkgs.writeShellApplication {
    name = "nixdots-hyprland-close-all-windows";
    runtimeInputs = [
      pkgs.jq
      pkgs.unstable.wayfreeze
      pkgs.slurp
      pkgs.grim
      pkgs.satty
    ];
    text = builtins.readFile ./nixdots-hyprland-close-all-windows;
  };
  nixdots-launch-browser = pkgs.writeShellApplication {
    name = "nixdots-launch-browser";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-launch-browser;
  };
  nixdots-launch-editor = pkgs.writeShellApplication {
    name = "nixdots-launch-editor";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-launch-editor;
  };
  nixdots-launch-or-focus = pkgs.writeShellApplication {
    name = "nixdots-launch-or-focus";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-launch-or-focus;
  };
  nixdots-launch-rofi = pkgs.writeShellApplication {
    name = "nixdots-launch-rofi";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-launch-rofi;
  };
  nixdots-toggle-waybar = pkgs.writeShellApplication {
    name = "nixdots-toggle-waybar";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-toggle-waybar;
  };
in
{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "nixdots-scripts";
      paths = [
        nixdots-battery-remaining
        nixdots-cmd-audio-switch
        nixdots-cmd-present
        nixdots-cmd-screenrecord
        nixdots-cmd-screenshot
        nixdots-hyprland-close-all-windows
        nixdots-launch-browser
        nixdots-launch-editor
        nixdots-launch-or-focus
        nixdots-launch-rofi
        nixdots-toggle-waybar
      ];
    })
  ];
}
