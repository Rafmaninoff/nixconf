{
  pkgs,
  lib,
  config,
  ...
}:
{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 30;
      consoleMode = "max";
      netbootxyz = {
        enable = true;
        sortKey = "y-netbootxyz";
      };
      memtest86 = {
        enable = true;
        sortKey = "z-memtest86";
      };
    };
  };
}
