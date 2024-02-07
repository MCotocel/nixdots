{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.matei = {
      isDefault = true;
      name = "Matei";
      settings = {
        "browser.compactmode.show" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.tabmanager.enabled" = false;
        "browser.tabs.tabMinWidth" = 10;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
      };
      extensions = with config.nur.repos.rycee.firefox-addons; [
        augmented-steam
        auto-tab-discard
        bitwarden
        brotab
        darkreader
        fediact
        i-dont-care-about-cookies
        ipfs-companion
        libredirect
        linkhints
        old-reddit-redirect
        privacy-badger
        qr-code-address-bar
        reddit-enhancement-suite
        refined-github
        steam-database
        terms-of-service-didnt-read
        ublock-origin
      ];
      userChrome = ''
        /* Make the tab background transparent, remove rounding, make the tabs a certain height */
        .tab-background {
          height = 30px;
          background-color: transparent !important; 
          border-radius: 0px 0px 0px 0px !important;
          margin-block: 1px 0 !important;
        }

        /* Underline the active tab */
        .tabbrowser-tab[selected="true"] .tab-background {
          border-bottom: 1px solid #80d1ff;
        }

       /* Make the tab length adjust to try and fill */
       .tabbrowser-tab[selected][fadein]:not([pinned]) {
         max-width: 10000px !important;
       }
       .tabbrowser-tab[fadein]:not([selected]):not([pinned]) {
         max-width: 10000px !important;
       }
       
       /* Hide the close button */
       .tabbrowser-tab .tab-close-button {
         visibility: collapse !important;
       }
      '';
    };
  };
}
