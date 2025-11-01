{ pkgs, pkgs-stable, lib, config, ... }:
with lib;
let
  cfg = config.has.gaming;
in
{
  options.has.gaming = mkOption {
    description = "enable gaming things.";
    type = types.bool;
    default = false;
  };

  config = mkIf cfg {
    users.groups.realtime = { };
    users.users.raf.extraGroups = [ "realtime" ];
    services.udev.extraRules = ''
      KERNEL=="cpu_dma_latency", GROUP="realtime"
    '';

    security.pam.loginLimits = [
      {
        domain = "@realtime";
        type = "-";
        item = "rtprio";
        value = "98";
      }
      {
        domain = "@realtime";
        type = "-";
        item = "memlock";
        value = "unlimited";
      }
      {
        domain = "@realtime";
        type = "-";
        item = "nice";
        value = "-11";
      }
    ];

    nixpkgs.config.packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          (writeShellScriptBin "launch-gamescope" ''
            (sleep 1; pgrep gamescope | xargs renice -n -11 -p)&
            exec gamescope "$@"
          '')
        ];
      };
    };

    environment.systemPackages = (with pkgs; [
      vulkan-tools
      gpu-viewer
      ckan
      ryubing
      dolphin-emu
      jstest-gtk
      evtest-qt
      (prismlauncher.override {
        jdks = with pkgs; [
          jdk8
          jdk17
          jdk21
          jdk25
        ] ++ [ pkgs-stable.graalvmPackages.graalvm-oracle ];
      })
      goverlay
      mangohud
      steamtinkerlaunch
      antimicrox
      protonup-ng
      protontricks
      protonup-qt
      protonplus
      xwayland-run
      cemu
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          obs-vkcapture
        ];
      })
      (lutris.override {
        extraPkgs = pkgs: [
          adwaita-icon-theme
          wineWowPackages.waylandFull
        ];
        extraLibraries = pkgs: [
          gst_all_1.gstreamer
        ];
      })
    ]) ++ (with pkgs-stable; [
      melonDS
    ]);

    programs.gamemode = {
      enable = true;
      enableRenice = true;
    };

    programs.gamescope = {
      enable = true;
      #capSysNice = true;
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };
}
