{ pkgs, lib, config, ... }: {
  i18n = {
    defaultLocale = "en_GB.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "es_UY.UTF-8";
      LC_IDENTIFICATION = "es_UY.UTF-8";
      LC_MEASUREMENT = "es_UY.UTF-8";
      LC_MONETARY = "es_UY.UTF-8";
      LC_NAME = "es_UY.UTF-8";
      LC_NUMERIC = "es_UY.UTF-8";
      LC_PAPER = "es_UY.UTF-8";
      LC_TELEPHONE = "es_UY.UTF-8";
      LC_TIME = "en_GB.UTF-8"; # ddmmyyyy and hh:mm
    };
  };
}
