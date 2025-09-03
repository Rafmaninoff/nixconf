{ pkgs, pkgs-stable, lib, config, ... }:
{
  imports = [
    ./fonts.nix
    ./discord.nix
    ./fcitx.nix
    ./gaming.nix
    ./kmonad.nix
    ./sound.nix
    ./sunshine-moonlight.nix
    ./openrgb.nix
  ];

  options.has.defaultDesktopPackages = lib.mkOption {
    description = "";
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkMerge [
    ({
      services.xserver.xkb = lib.mkDefault {
        layout = "us";
        variant = "";
        options = "compose:102,compose:menu,caps:hyper,lv3:ralt_switch";
      };
    })
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
          kdePackages.filelight
          vlc
          piper
          signal-desktop-bin
          telegram-desktop
          zapzap
          nchat
          scrcpy
          rnote
          pciutils
          usbutils
          btrfs-assistant
          firefox
          unrar
          krita
          gimp
          inkscape
          obsidian
          fractal
          quickemu
          tmux
        ]) ++ (with pkgs-stable; [
          libreoffice-qt
          hunspell
          hunspellDicts.es_ES
          hunspellDicts.en_GB-ise
          tor-browser-bundle-bin
        ]);
    })
  ];
}
