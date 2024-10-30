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
    environment.systemPackages = [ pkgs.input-leap ];
    allowedTCPPorts = [ 24800 ];
    allowedUDPPorts = [ 24800 ];
  };
}
