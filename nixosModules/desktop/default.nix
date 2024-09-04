{ pkgs, pkgs-stable, lib, config, ... }:
{
  imports = [
    ./waydroid.nix
    ./fonts.nix
    ./discord.nix
    ./gaming.nix
    ./fcitx.nix
    ./desktopPkgs.nix
  ];

  has.discord = lib.mkDefault true;
  has.waydroid = lib.mkDefault true;
  has.gaming = lib.mkDefault true;
  has.fcitx = lib.mkDefault true;
}
