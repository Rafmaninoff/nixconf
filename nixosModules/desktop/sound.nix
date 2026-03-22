{
  pkgs,
  lib,
  config,
  ...
}:
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
      extraConfig.pipewire-pulse."40-snapcast-sink" = {
        "pulse.cmd" = [
          {
            cmd = "load-module";
            args = "module-pipe-sink file=/run/snapserver/pipe sink_name=Snapcast format=s16le rate=48000";
          }
        ];
      };
    };
    services.snapserver = {
      enable = true;
      settings = {
        stream.source = "pipe:///run/snapserver/pipe?name=NAME";
      };
      openFirewall = true;
    };
    environment.systemPackages = with pkgs; [ snapclient ];
  };
}
