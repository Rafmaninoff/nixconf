{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.appimage;
in
{
  options.has.appimage = mkOption {
    description = "enable appimage support";
    type = types.bool;
    default = true;
  };

  config = mkIf config.has.appimage {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
