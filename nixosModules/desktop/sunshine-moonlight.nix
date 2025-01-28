{ pkgs, lib, config, ... }:
with lib;
{
  options.is.sunshine-host = mkOption {
    description = "make this host a sunshine host";
    type = types.bool;
    default = false;
  };

  options.has.moonlight = mkOption {
    description = "enable moonlight streaming client";
    type = types.bool;
    default = config.has.defaultDesktopPackages;
  };

  config = mkMerge [
    (mkIf config.has.moonlight { environment.systemPackages = [ pkgs.moonlight-qt ]; })
    (mkIf config.is.sunshine-host {
      services.sunshine = {
        enable = true;
        capSysAdmin = true;
        openFirewall = true;
      };
    })
  ];
}
