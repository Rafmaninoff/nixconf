{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.sound;
in
{
  options.has.sound = mkOption {
    description = "enable sound";
    type = types.bool;
    default = true;
  };

  config = mkIf cfg {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
