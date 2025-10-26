{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.fcitx;
in
{
  options.has.fcitx = mkOption {
    description = "enable fcitx im method";
    type = types.bool;
    default = true;
  };

  config = mkIf cfg {

    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        waylandFrontend = true;
        # addons = with pkgs; [
        #   fcitx5-mozc
        #   fcitx5-material-color
        # ];
      };
    };
  };
}
