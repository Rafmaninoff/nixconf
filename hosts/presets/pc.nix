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
      environment.sessionVariables."__NIXOS_PRESET" = "pc";

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      programs.ydotool = {
        group = "wheel";
        enable = true;
      };
    }
  ];



}
