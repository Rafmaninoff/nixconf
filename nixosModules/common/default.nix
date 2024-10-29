{ pkgs, lib, config, ... }: {
  imports =
    [
      ./bootloader.nix
      ./nixthings.nix
      ./locale.nix
      ./appimage.nix
      ./java.nix
      ./podman.nix
      ./flatpak.nix
      ./remotebuild.nix
    ];

  has.appimage = lib.mkDefault true;

}
