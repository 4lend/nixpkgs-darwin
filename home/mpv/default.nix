{ pkgs, ... }:

let
  mpvDir = ./.;
in
{
  xdg.configFile = {
    # File konfigurasi utama
    "mpv/mpv.conf".source = "${mpvDir}/mpv.conf";
    "mpv/input.conf".source = "${mpvDir}/input.conf";
    "mpv/profiles.conf".source = "${mpvDir}/profiles.conf";
    "mpv/subtitles.conf".source = "${mpvDir}/subtitles.conf";
    "mpv/README.md".source = "${mpvDir}/README.md";

    # Folder read-only (aman di-symlink ke nix store)
    "mpv/fonts".source = "${mpvDir}/fonts";
    "mpv/shaders".source = "${mpvDir}/shaders";
    "mpv/script-opts".source = "${mpvDir}/script-opts";
    "mpv/scripts".source = "${mpvDir}/scripts";
  };
}
