{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.my.fail2endlessh;
in
{
  options.my.fail2endlessh = {
    enable = mkOption {
      description = "Enable fail2ban with an endlesh jail, defaults to enabled if ssh is enabled";
      type = types.bool;
      default = config.services.sshd.enable;
    };

    sshdPort = mkOption {
      description = "sshd port";
      type = types.port;
      default = 22;
    };
    endlesshPort = mkOption {
      description = "port for endlessh";
      type = types.port;
      default = 2222;
    };
  };

  config = mkIf cfg.enable {

    services.openssh. ports = [ cfg.sshdPort ];

    services.endlessh-go = {
      enable = true;
      port = cfg.endlesshPort;
      openFirewall = true;
    };

    services.fail2ban = {
      enable = true;
      ignoreIP = [ "192.168.1.0/23" ];
      maxretry = 3;
      bantime-increment = {
        enable = true;
        rndtime = "10m";
      };
      daemonSettings = {
        DEFAULT = {
          dbpurgeage = "99y";
        };
      };
      jails.sshd.settings = {
        action = "endlessh";
        enable = true;
        mode = "aggressive";
      };
    };

    environment.etc."fail2ban/action.d/endlessh.conf".source =
      let
        dport = toString cfg.sshdPort;
        to-port = toString cfg.endlesshPort;
      in
      pkgs.writeText "endlessh.conf" ''
        [INCLUDES]
        before = iptables.conf

        [Definition]
        actionstart = <iptables> -t nat -N f2b-<name>
                      <iptables> -t nat -A f2b-<name> -j <returntype>
                      <iptables> -t nat -I PREROUTING -p tcp --dport ${dport} -j f2b-<name>

        actionstop = <iptables> -t nat -D PREROUTING -p tcp --dport ${dport} -j f2b-<name>
                     <actionflush>
                     <iptables> -t nat -X f2b-<name>

        actioncheck = <iptables> -t nat -n -L PREROUTING | grep -q 'f2b-<name>[ \t]'

        actionban = <iptables> -t nat -I f2b-<name> 1 -p tcp -s <ip> -j REDIRECT --dport ${dport} --to-port ${to-port}

        actionunban = <iptables> -t nat -D f2b-<name> -p tcp -s <ip> -j REDIRECT --dport ${dport} --to-port ${to-port}

        actionflush = <iptables> -t nat -F f2b-<name>

        [Init]
        blocktype = blackhole
      '';
  };
}
