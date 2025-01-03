# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];


  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [
    "surface_aggregator"
    "surface_aggregator_registry"
    "surface_aggregator_hub"
    "surface_hid"
    "surface_hid_core"
    "intel_lpss"
    "intel_lpss_pci"
    "8250_dw"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.blacklistedKernelModules = [ "ipu3_imgu" ];
  boot.extraModulePackages = [ ];

  boot.kernelParams = [ "mitigations=off" ];


  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/8947c991-d6d4-4ef1-af76-6564b0155e8d";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" "noatime" ];
    };

  boot.initrd.luks.devices."luks-6292a65c-3b13-4d84-9cb4-f23dfca59d8a".device = "/dev/disk/by-uuid/6292a65c-3b13-4d84-9cb4-f23dfca59d8a";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/C96E-DAF3";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings.max-jobs = lib.mkDefault 8;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
