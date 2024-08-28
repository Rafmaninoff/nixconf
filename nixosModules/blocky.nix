{ pkgs, lib, ... }:
{
  services.blocky = {
    enable = true;
    settings = {
      blocking = {
        denylists = {
          ads = [
            "https://adaway.org/hosts.txt"
            "https://raw.githubusercontent.com/blocklistproject/Lists/master/ads.txt"
            "https://raw.githubusercontent.com/blocklistproject/Lists/master/phishing.txt"
          ];
        };
        blockType = "zeroip";
        blockTTL = "6h";

        loading = {
          refreshPeriod = "4h";
          strategy = "fast";
          downloads = {
            timeout = "60s";
            attempts = 5;
            cooldown = "1s";
          };
        };

      };

      upstreams = {
        groups = {
          default = [ "8.8.8.8" "1.1.1.1" ];
        };

        strategy = "parallel_best";
      };

      bootstrapDns = {
        upstream = "https://dns.google/dns-query";
        ips = [ "8.8.8.8" "8.8.4.4" ];
      };

      caching = {
        prefetching = true;
        prefetchThreshold = 3;
      };

      connectIPVersion = "v4";

      ports = {
        dns = 53;
        tls = 853;
        https = 8444;
        http = 4000;
      };


    };

  };

  systemd.services.blocky = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
