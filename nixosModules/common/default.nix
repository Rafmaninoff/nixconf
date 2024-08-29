{ pkgs, lib, config, ... }:
{
  imports = [
    ./bootloader.nix
    ./nixthings.nix
    ./locale.nix
    ./appimage.nix
  ];

  has.appimage = lib.mkDefault true;

}
