{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.has.clac;
in
{
  options.has.clac = mkOption {
    description = "clac cli calculator";
    type = types.bool;
    default = true;
  };

  config = mkIf config.has.clac {

    home.packages = [ pkgs.clac ];
    xdg.configFile."clac/words".text = ''
      mc_toStacks "dup 64 % dup . - 64 / ,"
      mc_tobsi "dup 1728 % dup . - 1728 / , dup 64 % dup . - 64 / ,"
      mc_toNe "8 / . 8 / ,"
      mc_toOw "8 * . 8 * ,"
    '';
  };
}
