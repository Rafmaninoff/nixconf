{ config, inputs, pkgs, pkgs-stable, ... }:
{
  #systemd now refuses to boot with cgroups v1
  systemd.enableUnifiedCgroupHierarchy = true;

  services.ananicy = {
    enable = true;
    package = inputs.nixpkgs-stable.legacyPackages.x86_64-linux.ananicy-cpp;
    rulesProvider = inputs.nixpkgs.legacyPackages.x86_64-linux.ananicy-rules-cachyos;
    extraRules = [
      {
        name = "gamescope";
        nice = "-20";
      }
    ];
  };

}
