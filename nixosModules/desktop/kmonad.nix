{ pkgs, lib, config, ... }:
with lib;
{
  options.has.kmonad = mkEnableOption "enable kmonad";

  config = mkIf config.has.kmonad {
    environment.systemPackages = [ pkgs.kmonad ];

    users.groups = { uinput = { }; };

    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    users.users.raf.extraGroups = [ "uinput" ];

  };

}
