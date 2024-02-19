{ config, pkgs, ... }: {
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = false;
  };
}
