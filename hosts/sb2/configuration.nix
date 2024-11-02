# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../nixosModules/ananicy.nix
    ../../nixosModules/0t1.nix
    ../../nixosModules/sudo.nix
    ../../nixosModules/sops.nix
    ../../nixosModules/openrgb.nix
    ../../nixosModules/blocky.nix
    ../../nixosModules/duckdns.nix
    ../../nixosModules/desktop
    ../../nixosModules/net
    ../../nixosModules/common
  ];


  has.javawrappers = true;

  has.ssh = true;
  services.openssh.settings.PasswordAuthentication = true;

  services.iptsd = {
    enable = true;
    config.Touchscreen.DisableOnStylus = true;
  };

  environment.systemPackages = with pkgs; [
    maliit-keyboard
    maliit-framework
    powertop
    intel-gpu-tools
  ];

  networking.hostName = "sb2"; # Define your hostname.

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Montevideo";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  has.flatpak = {
    enable = true;
    flatpaks = [
      "org.jdownloader.JDownloader"
      "us.zoom.Zoom"
    ];
  };

  hardware.bluetooth = {
    enable = true;
  };

  users.users.raf = {
    isNormalUser = true;
    description = "raf";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" "adbusers" "surface-control" ];
  };

  programs.zsh.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.dirmngr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
