{ config, pkgs, pkgs-stable, lib, ... }:
{
  services.zerotierone = {
    enable = true;
  };
  # TODO: autojoin networks, blocked by secrets management.
}
