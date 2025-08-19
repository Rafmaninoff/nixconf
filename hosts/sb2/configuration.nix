# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

{
  imports = [
    #FIXME: temporary workaround for libcamera ipa module wireplumber crashing
    ./libcamera.nix

    ./hardware-configuration.nix
    ./disko-config.nix
    #import preset
    ../presets/pc.nix
    ../../nixosModules/common
    ../../nixosModules/desktop
    ../../nixosModules/net
  ];

  networking.hostName = "sb2"; # Define your hostname.

  has.gaming = true;

  boot.initrd.kernelModules = [ "pinctrl_sunrisepoint" ];

  boot.kernelParams = [ "mitigations=off" ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
    cpupower
    x86_energy_perf_policy
  ];

  boot.initrd.unl0kr = {
    allowVendorDrivers = true;
    enable = true;
  };

  #"stable or "longterm"
  hardware.microsoft-surface.kernelVersion = "stable";

  services.thermald.enable = lib.mkForce false;

  boot.kernel.sysctl = { "dev.i915.perf_stream_paranoid" = 0; };

  hardware.cpu.intel.updateMicrocode = true;

  services.cpupower-gui.enable = true;

  services.iptsd = {
    enable = true;
    config.Touchscreen.DisableOnStylus = true;
  };

  services.tlp.enable = lib.mkForce false;

  security.polkit.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Montevideo";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  programs.git.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raf = {
    isNormalUser = true;
    description = "raf";
    extraGroups =
      [ "networkmanager" "wheel" "input" "adbusers" "surface-control" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    maliit-keyboard
    maliit-framework
    powertop
    intel-gpu-tools
    kdePackages.qtsensors
    iio-sensor-proxy
    libsForQt5.qt5.qtsensors
    cheese
    webcamoid
    libcamera-qcam
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    cpufrequtils
    libva-utils
    kdePackages.kscreen
  ];

  has.ssh = true;
  services.openssh.settings.PasswordAuthentication = true;

  has.flatpak = {
    enable = true;
    flatpaks = [
      "org.jdownloader.JDownloader"
      "us.zoom.Zoom"
      "dev.vencord.Vesktop"
      "com.microsoft.Edge"
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
