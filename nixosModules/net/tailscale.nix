{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.tailscale;
in
{
  options.has.tailscale = mkOption {
    description = "use tailscale";
    type = types.bool;
    default = true;
  };

  config = mkIf config.has.tailscale {

    services.tailscale.enable = true;


  };

}
