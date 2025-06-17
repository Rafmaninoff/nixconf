{ pkgs, lib, config, ... }:
with lib;
{
  options.is.pc = mkOption {
    description = "enable common settings for personal computers";
    type = types.bool;
    default = true;
  };

  config = mkMerge [
    {
      #unconditional
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    }
  ];



}
