{ pkgs, lib, config, ... }: {
  imports = [
    ./ssh.nix
    ./fail2endlessh.nix
    ./zerotierone.nix
    ./tailscale.nix
  ];

  networking.firewall =
    let
      portsAll = [ 4656 63763 25565 27765 ];
    in
    {
      enable = true;
      allowedTCPPortRanges = [ ];
      allowedTCPPorts = portsAll ++ [ ];
      allowedUDPPortRanges = [ ];
      allowedUDPPorts = portsAll ++ [ ];
    };
}

