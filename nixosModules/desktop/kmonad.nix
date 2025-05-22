{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.myKmonad;
in
{
  options.myKmonad = mkOption {
    description = "enable kmonad and related";
    type = types.bool;
    default = true;
  };

  config = mkIf cfg {
    environment.systemPackages = [ pkgs.kmonad ];
    hardware.uinput.enable = true;
    users.users.raf.extraGroups = [ "uinput" ];
  };
}
