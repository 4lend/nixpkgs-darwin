{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Alfurqani";
        email = "syifa.alfurqoni@gmail.com";
      };
      # Contoh pengaturan tambahan bisa dimasukkan di sini
      # rerere.enable = true;
      # pull.ff = "only";
    };
    # Jika masih ingin menggunakan extraConfig, bisa juga seperti ini:
    # extraConfig = ''
    #   [rerere]
    #     enable = true
    #   [pull]
    #     ff = only
    # '';
  };
}
