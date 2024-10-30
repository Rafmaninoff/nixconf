{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.input-leap;
in
{
  options.has.input-leap = mkOption {
    description = "enable input-leap";
    type = types.bool;
    default = config.has.defaultDesktopPackages;
  };

  config = mkIf cfg {
    environment.systemPackages = [
      (pkgs.input-leap.overrideAttrs
        {
          src = pkgs.fetchFromGitHub {
            owner = "rafmaninoff";
            repo = "input-leap";
            rev = "v3.0.2-qt6.8";
            hash = "sha256-D4hXjcMOOc+l7XSW/AfBO5rx3sE5zxuhPf2HJyAJrjE=";
            fetchSubmodules = true;
          };
        })

    ];
    networking.firewall = {
      allowedTCPPorts = [ 24800 ];
      allowedUDPPorts = [ 24800 ];
    };
  };
}
