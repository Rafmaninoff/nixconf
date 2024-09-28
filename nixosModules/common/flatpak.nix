{ pkgs, lib, config, ... }:
with lib;
{
  options.has.flatpak = {
    enable = mkOption {
      description = "enable flatpaks";
      type = types.bool;
      default = false;
    };
    declarativeOnly = mkOption {
      description = "remove all flatpaks not defined declatively";
      type = types.bool;
      default = true;
    };
    flatpaks = mkOption {
      description = "list of flatpaks to install";
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf config.has.flatpak.enable {
    xdg.portal.enable = true;
    services.flatpak = {
      enable = true;
      uninstallUnmanaged = config.has.flatpak.declarativeOnly;
      packages = config.has.flatpak.flatpaks;
    };
  };
}
