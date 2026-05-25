{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  kcgroups = pkgs.callPackage ./pkg-kcgroups.nix { };
  plasma-foreground-booster = pkgs.callPackage ./pkg-plasma-foreground-booster.nix {
    kcgroups = pkgs.callPackage ./pkg-kcgroups.nix { };
  };
  dmemcg-booster = pkgs.callPackage ./pkg-dmemcg-booster.nix { };
in
{
  options.vram-prio = mkOption {
    description = "enable vram prioritisation fixup";
    type = types.bool;
    default = false;
  };

  config = mkIf config.vram-prio {
    environment.systemPackages = [
      kcgroups
      plasma-foreground-booster
      dmemcg-booster
      pkgs.amdgpu_top
    ];

    systemd.packages = [ dmemcg-booster ];

    systemd.services.dmemcg-booster-system = {
      overrideStrategy = "asDropin";
      wantedBy = [ "multi-user.target" ];
    };

    systemd.user.services.dmemcg-booster-user = {
      overrideStrategy = "asDropin";
      wantedBy = [ "graphical-session-pre.target" ];
    };

  };

}
