{ pkgs, lib, config, ... }:
with lib;
{
  options.has.fcitx = mkEnableOption "enable fcitx input method";

  config = mkIf config.has.fcitx {
    i18n = {
      inputMethod = {
        type = "fcitx5";
        enable = true;
        fcitx5 = {
          waylandFrontend = true;
          addons = with pkgs; [
            fcitx5-mozc
            fcitx5-material-color
          ];
        };
      };
    };
  };

}
