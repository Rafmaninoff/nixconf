{ config, pkgs-stable, lib, ... }:
{
  options.has.zerotierone = lib.mkOption
    {
      description = "enable zeroTierOne";
      type = lib.types.bool;
      default = config.has.defaultDesktopPackages;
    };

  config = lib.mkIf config.has.zerotierone {
    services.zerotierone = {
      enable = true;
      package = pkgs-stable.zerotierone;
    };
  };
}
