{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      style = "numbers,changes,header";
    };
    extraPackages = builtins.attrValues {
      inherit (pkgs.bat-extras)
        batgrep # search through and highlight files using ripgrep
        batdiff # diff a file against the current git index, or display the diff between to files
        batman # read manpages using bat as the formatter
        ;
    };
  };

  home.activation.batCacheRebuild = {
    after = [ "linkGeneration" ];
    before = [ ];
    data = ''
      ${pkgs.bat}/bin/bat cache --build
    '';
  };
}
