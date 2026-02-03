{
  config,
  lib,
  ...
}:
let
  homeDirectory = config.home.homeDirectory;
in
{
  home = {
    sessionPath = lib.flatten ([
      "${homeDirectory}/scripts/"
    ]);
  };
}
