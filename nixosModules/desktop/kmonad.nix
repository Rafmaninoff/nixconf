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
    users.groups = { uinput = { }; };
    services.udev.extraRules = ''
      KERNEL="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput";
    '';
    users.users.raf.extraGroups = [ "uinput" ];
  };
}
