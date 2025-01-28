{ config, lib, pkgs, ... }:
with lib;
{
  options.has.ananicy = mkOption {
    description = "enable ananicy";
    type = types.bool;
    default = config.has.defaultDesktopPackages;
  };

  config = mkIf config.has.ananicy {
    services.ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
      extraRules = [
        {
          name = "gamescope";
          nice = "-20";
        }
      ];
    };
  };
}
