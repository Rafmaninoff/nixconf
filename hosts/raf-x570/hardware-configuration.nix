{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];


  boot.initrd.availableKernelModules = [ "nvme" "usbhid" "uas" "usb_storage" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.tmp = {
    cleanOnBoot = true;
    tmpfsSize = "80%";
  };

  boot.initrd.luks.devices = {
    nixos-root = {
      device = "/dev/disk/by-uuid/b15fb526-f5f6-4ca3-be4e-f8fec733361b";
      allowDiscards = true;
      bypassWorkqueues = true;
      # preLVM = false;
      # fallbackToPassword = true;
      keyFileSize = 4096;
      keyFile = "/dev/disk/by-id/usb-A-DATA_USB_Flash_Drive_eed3a583ad6702-0:0";
    };
    nixos-swap = {
      device = "/dev/disk/by-uuid/1ea26456-bf06-4ae4-96a7-df33c7c8fe4c";
      allowDiscards = true;
      bypassWorkqueues = true;
      # preLVM = false;
      # fallbackToPassword = true;
      keyFileSize = 4096;
      keyFile = "/dev/disk/by-id/usb-A-DATA_USB_Flash_Drive_eed3a583ad6702-0:0";
    };
    fastfiles2 = {
      device = "/dev/disk/by-uuid/3eec1d54-5682-4729-82b9-6f88075b46ea";
      allowDiscards = true;
      bypassWorkqueues = true;
      # preLVM = false;
      # fallbackToPassword = true;
      keyFileSize = 4096;
      keyFile = "/dev/disk/by-id/usb-A-DATA_USB_Flash_Drive_eed3a583ad6702-0:0";
    };
    fastfiles1 = {
      device = "/dev/disk/by-uuid/2d462c16-45b1-43e2-9159-0e6dfb9450bd";
      allowDiscards = true;
      bypassWorkqueues = true;
      # preLVM = false;
      # fallbackToPassword = true;
      keyFileSize = 4096;
      keyFile = "/dev/disk/by-id/usb-A-DATA_USB_Flash_Drive_eed3a583ad6702-0:0";
    };
    slowfiles1 = {
      device = "/dev/disk/by-uuid/168c7368-8c26-480e-bd59-2d52f175a639";
      # preLVM = false;
      # fallbackToPassword = true;
      keyFileSize = 4096;
      keyFile = "/dev/disk/by-id/usb-A-DATA_USB_Flash_Drive_eed3a583ad6702-0:0";
    };
    slowfiles2 = {
      device = "/dev/disk/by-uuid/52fe8ee0-38b0-41de-a675-9e6f1b1b3fd0";
      # preLVM = false;
      # fallbackToPassword = true;
      keyFileSize = 4096;
      keyFile = "/dev/disk/by-id/usb-A-DATA_USB_Flash_Drive_eed3a583ad6702-0:0";
    };
    slowfiles3 = {
      device = "/dev/disk/by-uuid/27c953b0-afeb-471a-a0f5-9b7992fcdd88";
      # preLVM = false;
      # fallbackToPassword = true;
      keyFileSize = 4096;
      keyFile = "/dev/disk/by-id/usb-A-DATA_USB_Flash_Drive_eed3a583ad6702-0:0";
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/NIXOSESP";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/mapper/nixos-root";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" ];
    };
    "/mnt/fastfiles2" = {
      device = "/dev/mapper/fastfiles2";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" ];
    };
    "/mnt/fastfiles1" = {
      device = "/dev/mapper/fastfiles1";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" ];
    };
    "/mnt/slowfiles1" = {
      device = "/dev/mapper/slowfiles1";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" ];
    };
    "/mnt/slowfiles2" = {
      device = "/dev/mapper/slowfiles2";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" ];
    };
    "/mnt/slowfiles3" = {
      device = "/dev/mapper/slowfiles3";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" ];
    };
  };

  swapDevices = [{ device = "/dev/mapper/nixos-swap"; }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings.max-jobs = lib.mkDefault 12;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableAllFirmware = true;

}
