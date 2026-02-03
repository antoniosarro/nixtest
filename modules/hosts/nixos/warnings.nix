{ config, lib, ... }:
{
  options = with lib; {
    configOptions.silencedWarnings = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        list of `config.warnings` values you want to ignore, verbatim.
      '';
    };
    warnings = mkOption {
      apply = builtins.filter (w: !(builtins.elem w config.configOptions.silencedWarnings));
    };
  };
}
