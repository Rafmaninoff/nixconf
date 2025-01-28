{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.discord;
in
{
  options.has.discord = mkOption {
    description = "Enable discord and related things";
    type = types.bool;
    default = true;
  };

  config = mkIf cfg {
    environment.systemPackages = with pkgs; [ vesktop equibop arrpc ];
    systemd.user.services = {
      arrpc = {
        partOf = [ "graphical-session.target" ];
        after = [ "graphical-sesstion.target" ];
        wantedBy = [ "graphical-session.target" ];

        description = "Discord rich presence for non-default clients";
        serviceConfig = {
          ExecStart = "${getExe pkgs.arrpc}";
          Restart = "always";
        };
      };
    };
  };
}
