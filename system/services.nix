{ config, pkgs, ... }:

{
  services.dnscrypt-proxy = {
    enable = true;
    # Configure dnscrypt-proxy settings here.
    # These settings are converted to a TOML config file for dnscrypt-proxy.
    settings = {
      # Example: Use specific DNS over HTTPS (DoH) servers
      doh_servers = true;
      server_names = [ "cloudflare" "google" ]; # Example server names
      # You can also configure other options like listen_addrs,
      # block lists, forwarding rules, etc.
      # Refer to the dnscrypt-proxy example-dnscrypt-proxy.toml for available options.
      # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
    };
  };

  # Ensure your system uses dnscrypt-proxy for DNS resolution
  # This typically means setting your DNS resolver to the address dnscrypt-proxy listens on (e.g., 127.0.0.53)
  networking.extraHosts = "127.0.0.53 dnscrypt-proxy"; # Optional, for clarity
  # You might also need to configure systemd-resolved or other DNS clients
  # to point to dnscrypt-proxy's listening address.
  # Example for systemd-resolved:
  # systemd.resolved.extraConfig = "DNS=127.0.0.53";
}
