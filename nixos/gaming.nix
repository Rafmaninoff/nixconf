{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    prismlauncher
    goverlay
    steamtinkerlaunch

  ];
}
