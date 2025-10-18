{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../presets/pc.nix
    ./hardware-configuration.nix
    ../../nixosModules/desktop
    ../../nixosModules/net
    ../../nixosModules/common
  ];

  has.javawrappers = true;

  networking.hostName = "raf-x570";

  has.gaming = true;
  has.openrgb = true;

  programs.adb.enable = true;

  services.input-remapper.enable = true;

  services.ratbagd.enable = true;

  programs.corectrl.enable = true;

  is.sunshine-host = true;

  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  boot.kernelParams = [ "mitigations=off" "amdgpu.dcdebugmask=0x400" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.scx = {
    enable = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      mesa.opencl
    ];
  };

  hardware.amdgpu.overdrive = {
    enable = true;
    ppfeaturemask = "0xffffffff";
  };

  networking.networkmanager.enable = true;

  time.timeZone = "America/Montevideo";

  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  programs.git.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs.zsh.enable = true;

  users.users.raf = {
    isNormalUser = true;
    description = "raf";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" "adbusers" "video" ];
  };

  environment.systemPackages = with pkgs; [
    teamspeak6-client
  ];

  has.zerotierone = true;



  has.ssh = true;
  services.openssh.settings.PasswordAuthentication = true;

  has.flatpak = {
    enable = true;
    flatpaks = [
      "org.jdownloader.JDownloader"
      "us.zoom.Zoom"
      "com.usebottles.bottles"
      "com.microsoft.Edge"
    ];
  };

  has.libvirt = true;


  system.stateVersion = "25.05";
}
