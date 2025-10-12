{ pkgs, config, ... }:

{
  programs.yt-dlp = {
    enable = true;
    settings = {
      sub-langs = "en,id";
	    downloader = "curl";  # native, aria2c, axel, curl, wget, ffmpeg, httpie, avconf
	    write-subs = true;
	    write-auto-subs = true;
      merge-output-format = "webm/mkv/mp4";
    };
  };
}
