{ pkgs, lib, config, ... }:
{
  boot.initrd.systemd.enable = true;
  boot.initrd.unl0kr.enable = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 30;
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
