{ pkgs, lib, config, ... }:
with lib;
{
  options.has.sound = mkOption {
    description = "enable sound";
    type = types.bool;
    default = true;
  };

  config = mkIf config.has.sound {
<<<<<<< HEAD
=======

>>>>>>> b8974eba8af5e483142377d6beab67e10e62bcd1
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
