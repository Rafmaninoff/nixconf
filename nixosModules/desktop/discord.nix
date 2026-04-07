{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.has.discord;
  krisp-patcher =
    pkgs.writers.writePython3Bin "krisp-patcher"
      {
        libraries = with pkgs.python3Packages; [
          capstone
          pyelftools
        ];
        flakeIgnore = [
          "E501" # line too long (82 > 79 characters)
          "F403" # 'from module import *' used; unable to detect undefined names
          "F405" # name may be undefined, or defined from star imports: module
        ];
      }
      (
        builtins.readFile (
          pkgs.fetchurl {
            url = "https://pastebin.com/raw/8tQDsMVd";
            sha256 = "sha256-IdXv0MfRG1/1pAAwHLS2+1NESFEz2uXrbSdvU9OvdJ8=";
          }
        )
      );
in
{
  options.has.discord = mkOption {
    description = "Enable discord and related things";
    type = types.bool;
    default = true;
  };

  config = mkIf cfg {
    environment.systemPackages = with pkgs; [
      vesktop
      equibop
      arrpc
      krisp-patcher
      (discord.override {
        # withOpenASAR = true;
        withVencord = true;
      })
    ];
    systemd.user.services = {
      arrpc = {
        partOf = [ "graphical-session.target" ];
        after = [ "graphical-sesstion.target" ];
        wantedBy = [ "graphical-session.target" ];

        description = "Discord rich presence for non-default clients";
        serviceConfig = {
          ExecStart = "${getExe pkgs.arrpc}";
          Restart = "always";
        };
      };
    };
  };
}
