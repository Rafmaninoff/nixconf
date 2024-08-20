{ config, pkgs, pkgs-stable, lib, ... }:
{
  services.zerotierone = {
    enable = true;
    package = pkgs-stable.zerotierone;
  };
  # TODO: autojoin networks, blocked by secrets management.
}
