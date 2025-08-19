# Fix wireplumber from segfaults until this is in https://github.com/NixOS/nixpkgs/pull/427606
# grabbed from https://gist.github.com/outten45/94361183164ab5e7790253c685176e57
# 
# add to "imports" and then enable option:
#
#   `services.pipewire.useCustomLibcamera = true;`


{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Custom libcamera with post-processing
  customLibcamera = pkgs.libcamera.overrideAttrs (old: {
    postFixup = ''
      echo "Running ipa-sign-install.sh on libcamera IPA modules..."
      ../src/ipa/ipa-sign-install.sh src/ipa-priv-key.pem $out/lib/libcamera/ipa/ipa_*.so
    '';
  });

  # Override libcamera system-wide
  customPkgs = pkgs.extend (
    final: prev: {
      libcamera = customLibcamera;
    }
  );
in
{
  options.services.pipewire.useCustomLibcamera = lib.mkEnableOption "Use custom libcamera with postFixup step in pipewire";

  config = lib.mkIf config.services.pipewire.useCustomLibcamera {
    # Use the custom package set for pipewire services
    services.pipewire = {
      enable = true;
      package = customPkgs.pipewire;
      wireplumber.package = customPkgs.wireplumber;
    };

    # Optional: expose custom libcamera system-wide
    environment.systemPackages = [ customLibcamera ];
