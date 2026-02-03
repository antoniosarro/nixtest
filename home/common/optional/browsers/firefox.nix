{ config, ... }:
let
  homeDir = config.home.homeDirectory;
in
{
  programs.firefox = {
    enable = true;

    # Refer to https://mozilla.github.io/policy-templates or `about:policies#documentation` in firefox
    policies = {
      AppAutoUpdate = false; # disable automatic application update
      BackgroundAppUpdate = false; # disable automatic application update in the background, when the application is not running
      DefaultDownloadDirectory = "${config.home.homeDirectory}/downloads";
      DisableBuiltinPDFViewer = false;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = false; # Enable Firefox Sync
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      ExtensionUpdate = false;

      ExtensionSettings =
        (
          let
            extension = shortId: uuid: {
              name = uuid;
              value = {
                install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
                installation_mode = "normal_installed";
              };
            };
          in
          builtins.listToAttrs [
            # privacy / Security
            (extension "noscript" "{73a6fe31-595d-460b-a920-fcc0f8843232}")
            (extension "proton-vpn-firefox-extension" "vpn@proton.ch")
            (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
            (extension "cookie-autodelete" "CookieAutoDelete@kennydo.com")
            (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")

            # adblock
            (extension "ublock-origin" "uBlock0@raymondhill.net")
            # https://github.com/AdguardTeam/AdGuardExtra

            # layout / Themeing
            (extension "darkreader" "addon@darkreader.org")
            (extension "adaptive-tab-bar-colour" "ATBC@EasonWong")
            (extension "refined-github-" "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}")

            # misc
            (extension "auto-tab-discard" "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}")
            (extension "betterttv" "firefox@betterttv.net")
            (extension "keepa" "amptra@keepa.com")
            (extension "multi-account-containers" "@testpilot-containers")
            (extension "open-graph-previewer" "ruben.winant@hotmail.com")
          ]
        )
        // {
        };
    };

    profiles.main = {
      id = 0;
      name = "ohhbigg";
      isDefault = true;
      settings = {
        "signon.rememberSignons" = false; # disable built-in password manager
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1; # enable compact mode
        "browser.aboutConfig.showWarning" = false;
        "browser.download.dir" = "${homeDir}/downloads";
        "browser.tabs.firefox-view" = true; # sync tabs across devices
        "ui.systemUsesDarkTheme" = 1; # force dark theme
        "extensions.pocket.enabled" = false;
      };
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "application/pdf" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };
}
