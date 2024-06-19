{ pkgs, config, lib, ... }:
{
  services.endlessh = {
    enable = true;
    port = 2222;
  };
}
