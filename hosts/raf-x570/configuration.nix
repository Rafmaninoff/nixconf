# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:
let
  pkgs-stable = inputs.nixpkgs-stable.legacyPackages.x86_64-linux;
  kmonad = (import ../../nixosModules/kmonad.nix) pkgs;
in
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

  services.duckdns = {
    enable = true;
    domains = [ "rafmaninoff" ];
    tokenFile = /run/secrets/duckdns_token;
  };

  has.javawrappers = true;

  networking.hostName = "raf-x570"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
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

  programs.hyprland = { enable = true; };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "compose:102,caps:hyper,lv3:ralt_switch";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # services.blueman.enable = true;

  services.flatpak.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raf = {
    isNormalUser = true;
    description = "raf";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" "adbusers" ];
  };

  users.groups = { uinput = { }; };

  services.udev.extraRules = ''
    # KMonad user access to /dev/uinput
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  programs.adb.enable = true;

  virtualisation = {
    spiceUSBRedirection.enable = true;
    podman = {
      enable = false;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  xdg.portal.enable = true;

  services.input-remapper = { enable = true; };

  environment.systemPackages = (with pkgs; [
    kmonad
  ]);

  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ ];
  };

  services.ratbagd.enable = true;

  programs.zsh.enable = true;
  programs.kdeconnect.enable = true;

  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.dirmngr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall = { enable = true; };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
