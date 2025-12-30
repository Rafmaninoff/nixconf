{ pkgs, lib, config, ... }:
{
  nix = {
    package = pkgs.lix;
    settings.experimental-features = [ "nix-command" "flakes" "pipe-operator" ];
    settings.substituters = [
      "https://watersucks.cachix.org"
      "https://attic.xuyh0120.win/lantian"
    ];
    settings.trusted-public-keys = [
      "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
    optimise = {
      automatic = true;
      dates = [ "00:00:00" ];
    };
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 15d --keep 5";
    };
    flake = "/home/raf/nixconf/";
  };

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [

    ];
  };

  services.nixos-cli = {
    enable = true;
  };
}
