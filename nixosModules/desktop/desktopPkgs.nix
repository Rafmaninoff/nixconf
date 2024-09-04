{ pkgs, pkgs-stable, lib, config, ... }:
with lib;
let
  cfg = config.has.defaultDesktopPackages;
in
{
  options.has.defaultDesktopPackages = mkOption {
    description = "enable my default set of desktop packages";
    type = types.bool;
    default = true;
  };

  config = mkIf config.has.defaultDesktopPackages {
    environment.systemPackages =
      (with pkgs; [
        sops
        vim
        age
        gnome-disk-utility
        deluge
        wget
        flameshot
        filelight
        clac
        vlc
        piper
        signal-desktop
        telegram-desktop
        zapzap
        nchat
        scrcpy
        rnote
        pciutils
        usbutils
        stremio
        btrfs-assistant
        quickemu
        floorp
        firefox
        microsoft-edge
      ])
      ++ (with pkgs-stable; [
        libreoffice-qt
        hunspell
        hunspellDicts.es_ES
        hunspellDicts.en_GB-ise
      ]);

  };

}
