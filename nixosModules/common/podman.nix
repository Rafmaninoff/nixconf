{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.podman;
in
{
  options.has.podman = mkOption {
    description = "enable podman";
    type = types.bool;
    default = false;
  };

  config = mkIf config.has.podman {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
