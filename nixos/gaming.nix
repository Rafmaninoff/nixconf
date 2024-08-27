{ pkgs, ... }:
{
  users = {
    users.raf.extraGroups = [ "realtime" ];
    groups.realtime = { };
  };
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

  environment.systemPackages = with pkgs; [
    vulkan-tools
    gpu-viewer
    ckan
    ryujinx
    cemu
    melonDS
    jstest-gtk
    sdl-jstest
    evtest-qt
    prismlauncher
    goverlay
    mangohud
    steamtinkerlaunch
    antimicrox
    protonup
    protonup-qt
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
  ];

  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  programs.gamescope = {
    enable = true;
    # capSysNice = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
}
