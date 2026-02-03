{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = ''
      set-option -g default-terminal 'tmux-256color'
      set-option -sa terminal-features ',xterm-kitty:RGB'
    '';
  };
}
