{ pkgs, ... }:
{
  imports = [
    # a cat clone with syntax highlighting and Git integration
    ./bat.nix

    # load and unload environment variables depending on the current directory
    ./direnv.nix

    # modern, maintained replacement for ls
    ./eza.nix

    # system information tool
    ./fastfetch.nix

    # command-line fuzzy finder written in Go
    ./fzf.nix

    # simple terminal UI for git commands
    ./lazygit.nix

    # minimal, blazing fast, and extremely customizable prompt for any shell
    ./starship.nix

    # terminal multiplexer
    ./tmux.nix

    # fast cd command that learns your habits
    ./zoxide.nix

    # z shell
    ./zsh.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      btop
      curl
      wget
      ;
  };
}
