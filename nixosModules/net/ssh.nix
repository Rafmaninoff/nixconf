{ pkgs, config, lib, ... }:
with lib;
{
  options.has.ssh = mkEnableOption "enable sshd";

  config = mkIf config.has.ssh {
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
