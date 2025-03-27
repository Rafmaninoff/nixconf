{ pkgs, lib, config, ... }: {
  imports = [
    ./ssh.nix
    ./fail2endlessh.nix
    ./zerotierone.nix
    ./tailscale.nix
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [ ];
    allowedTCPPorts = [ 4656 ];
    allowedUDPPortRanges = [ ];
    allowedUDPPorts = [ ];
  };
}

