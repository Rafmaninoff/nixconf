{ pkgs, config, lib, ... }:
{
  services.fail2ban = {
    enable = true;
    maxretry = 3;
    ignoreIP = [ "192.168.1.0/23" ];
    bantime = "24h";
    bantime-increment = {
      enable = true;
      formula = "bantime * math.exp(float(ban.Count + 1) * banFactor)/math.exp(1*banFactor)";
      factor = "1";
      rndtime = "8m";
      overalljails = true;
    };
    jails.sshd = lib.mkDefault (lib.mkAfter ''mode = aggressive'');
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
    settings = {
      PasswordAuthentication = true;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

}
