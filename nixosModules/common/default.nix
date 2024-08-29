{ pkgs, lib, config, ... }:
{
  imports = [
    ./bootloader.nix
    ./nixthings.nix
    ./locale.nix
  ];

}
