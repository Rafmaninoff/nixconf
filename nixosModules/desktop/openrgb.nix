{ config, lib, pkgs, ... }:
with lib;
{
  options.has.openrgb = mkOption {
    description = "enable openRGB";
    type = types.bool;
    default = false;
  };

  config = mkIf config.has.openrgb {
    boot.kernelModules = [ "i2c-dev" ];
    hardware.i2c.enable = true;
    services.hardware.openrgb.enable = true;
  };

}
