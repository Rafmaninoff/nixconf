{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../nixosModules/desktop
    ../../nixosModules/net
    ../../nixosModules/common
  ];

  has.javawrappers = true;

  networking.hostName = "raf-x570";

  has.gaming = true;

  programs.adb.enable = true;

  services.input-remapper.enable = true;

  services.ratbagd.enable = true;

  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };

  is.sunshine-host = true;

  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.kernelParams = [ "mitigations=off" "amdgpu.dcdebugmask=0x400" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.graphics = { enable = true; };

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

  ];

  has.ssh = true;
  services.openssh.settings.PasswordAuthentication = true;

  has.flatpak = {
    enable = true;
    flatpaks = [
      "org.jdownloader.JDownloader"
      "us.zoom.Zoom"
      "dev.vencord.Vesktop"

    ];
  };


  system.stateVersion = "25.05";
}
