{ pkgs, lib, config, ... }:
{
  nix = {
    package = pkgs.lix;
    settings.experimental-features = [ "nix-command" "flakes" ];
    optimise = {
      automatic = true;
      dates = [ "00:00:00" ];
    };
  };

  services.nixos-cli = {
    enable = true;
    prebuildOptionCache = true;
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 15d --keep 5";
    };
    flake = "/home/raf/nixconf";
  };

}
