{
  pkgs,
  config,
  ...
}:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      vesktop
      ;
  };

  home.file."${config.home.homeDirectory}/.config/vesktop/themes" = {
    source = ./themes;
    recursive = true;
  };
}
