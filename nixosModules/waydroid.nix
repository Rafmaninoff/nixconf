{ pkgs, lib, config, ... }: {

  options.has.waydroid = lib.mkEnableOption "enable waydroid";

  config = lib.mkIf config.has.waydroid {
    virtualisation.waydroid.enable = true;
  };

}
