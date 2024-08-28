{ pkgs, lib, config }:
{
  imports = [
    ./waydroid.nix
    ./fonts.nix
    ./discord.nix
  ];

  has.discord = lib.mkDefault true;
  has.waydroid = lib.mkDefault true;




}
