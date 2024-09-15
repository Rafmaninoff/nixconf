{ pkgs, lib, config, ... }: {
  imports = [
    ./ssh.nix
    ./fail2endlessh.nix
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [ ];
    allowedTCPPPorts = [ ];
    allowedUDPPortRanges = [ ];
    allowedUDPPorts = [ ];
  };
}

