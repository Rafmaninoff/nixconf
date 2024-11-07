{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.avahi;
in
{
  options.has.avahi = mkOption {
    description = "enable avahi zeroconf";
    type = types.bool;
    default = false;
  };

  config = mkIf config.has.avahi {
    services.avahi = {
      enable = true;
      openFirewall = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
    networking.firewall.allowPing = true;
  };

}
