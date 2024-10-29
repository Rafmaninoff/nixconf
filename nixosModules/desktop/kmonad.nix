{ pkgs, lib, config, ... }:
with lib;
{

  options.has.myKmonad = mkOption {
    description = "enable kmonad";
    type = types.bool;
    default = false;
  };

  config = mkIf config.has.myKmonad {
    environment.systemPackages = [ pkgs.kmonad ];

    users.groups = { uinput = { }; };

    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    users.users.raf.extraGroups = [ "uinput" ];

  };

}
