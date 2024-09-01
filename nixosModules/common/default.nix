{ pkgs, lib, config, ... }: {
  imports =
    [ ./bootloader.nix ./nixthings.nix ./locale.nix ./appimage.nix ./java.nix ];

  has.appimage = lib.mkDefault true;

}
