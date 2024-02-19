{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    prismlauncher
    yuzu-early-access

  ];
}
