{ config, pkgs, ... }: {
  config = {
    boot.kernelModules = [ "i2c-dev" ];
    hardware.i2c.enable = true;
    services.hardware.openrgb.enable = true;
  };

}
