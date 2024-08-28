{ pkgs, lib, config }:
{

  options.has.discord = lib.mkEnableOption "enable discord and related things";

  config = lib.mkIf config.has.discord {
    environment.systemPackages = with pkgs; [ vesktop arrpc ];
    systemd.user.services = {
      arrpc = {
        partOf = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];

        description = "Discord rich presence for non-default clients";
        serviceConfig = {
          ExecStart = "${lib.getExe pkgs.arrpc}";
          Restart = "always";
        };
      };
    };
  };

}
