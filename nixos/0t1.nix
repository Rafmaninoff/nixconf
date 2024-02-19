{ config, pkgs, ... }:
{
  services.zerotierone.enable = true;
  # TODO: autojoin networks, blocked by secrets management.
}
