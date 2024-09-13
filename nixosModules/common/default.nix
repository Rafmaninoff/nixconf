{ pkgs, lib, config, ... }: {
  imports =
    [
      ./bootloader.nix
      ./nixthings.nix
      ./locale.nix
      ./appimage.nix
      ./java.nix
      ./podman.nix
    ];

  has.appimage = lib.mkDefault true;

}
