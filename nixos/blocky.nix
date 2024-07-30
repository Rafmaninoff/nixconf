{ pkgs, ... }:
{
  services.blocky = {
    enable = true;
    settings = {
      blocking = {
        blackLists = {
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

        strategy = "parrallel_best";
      };

      bootstrapDns = {
        ips = [ "8.8.8.8" "8.8.4.4" ];
      };

      caching = {
        prefetching = true;
        prefetchThreshold = 3;
      };

      connectIPVersion = "v4";

      startVerifyUpsream = true;

      ports = {
        dns = 53;
        tls = 853;
        https = 8444;
        http = 4000;
      };


    };

  };

}
