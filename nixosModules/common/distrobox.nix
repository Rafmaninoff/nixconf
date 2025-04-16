{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.distrobox;
in
{
  options.has.distrobox = mkOption {
    description = "enable distrobox";
    type = types.bool;
    default = true;
  };

  config = mkIf config.has.distrobox {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
    environment.systemPackages = with pkgs; [ distrobox ];

  };

}
