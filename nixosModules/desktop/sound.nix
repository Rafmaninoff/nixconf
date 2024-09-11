{ pkgs, lib, config, ... }:
with lib;
{
  options.has.sound = mkOption {
    description = "enable sound";
    type = types.bool;
    default = true;
  };

  config = mkIf config.has.sound {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      media-session.enable = true;
    };
  };


}
