{
  pkgs,
  config,
  ...
}:
let
  handle = config.hostSpec.handle;
  publicGitEmail = config.hostSpec.email.github;
in
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    ignores = [
      "*.drv"
      "result"
      "*.py?"
      "__pycache__/"
      ".venv/"
      ".direnv"
      "node_modules"
      ".cache/"
      ".DS_Store"
    ];

    userName = handle;
    userEmail = publicGitEmail;
    aliases = { };
    extraConfig = {
      log.showSignature = "true";
      init.defaultBranch = "main";
      pull.rebase = "true";
      push.autoSetupRemote = true;
    };
  };
}
