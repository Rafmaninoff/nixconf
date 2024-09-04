{ pkgs, pkgs-stable, lib, config, ... }:
{
  imports = [
    ./waydroid.nix
    ./fonts.nix
    ./discord.nix
    ./gaming.nix
    ./fcitx.nix
  ];

  options.has.defaultDesktopPackages = lib.mkOption {
    description = "";
    type = lib.types.bool;
    default = true;
  };


  config = lib.mkMerge [
    {
      has.discord = lib.mkDefault true;
      has.waydroid = lib.mkDefault true;
      has.gaming = lib.mkDefault true;
      has.fcitx = lib.mkDefault true;
    }
    (lib.mkIf config.has.defaultDesktopPackages {
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
    })
  ];
}
