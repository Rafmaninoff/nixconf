{ pkgs, lib, config, ... }:
{
  imports = [
    ./waydroid.nix
    ./fonts.nix
    ./discord.nix
    ./gaming.nix
  ];

  has.discord = lib.mkDefault true;
  has.waydroid = lib.mkDefault true;
  has.gaming = lib.mkDefault true;




}
