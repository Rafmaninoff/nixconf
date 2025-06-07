{ config, lib, pkgs, ... }: {
  imports = [
    ./sudo.nix
    ./appimage.nix
    ./bootloader.nix
    ./nixthings.nix
    ./flatpak.nix
    ./java.nix
    ./locale.nix
    ./distrobox.nix
    ./libvirt.nix
  ];


}
