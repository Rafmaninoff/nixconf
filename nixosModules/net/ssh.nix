{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.has.ssh;
in
{
  options.has.ssh = mkEnableOption "enable sshd";

  config = mkIf cfg.has.ssh {
    services.openssh = {
      enable = true;
      ports = mkDefault [ 22 ];
      openFirewall = true;
      settings = {
        PasswordAuthentication = mkDefault false;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "no";
      };
    };
  };

}
