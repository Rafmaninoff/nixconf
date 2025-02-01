{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.ghostty;
in
{
  options.has.ghostty = mkOption {
    description = "enable ghostty terminal emulator";
    type = types.bool;
    default = true;
  };

  config = mkIf cfg {
    programs.ghostty = {
      enable = true;
    };
  };
}
