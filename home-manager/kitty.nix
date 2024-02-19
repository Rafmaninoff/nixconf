{ inputs, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "VictorMono Nerd Font";
      size = 13;
    };
    settings = {
      disable_ligatures = "never";
      enable_audio_bell = "yes";

    };
    theme = "Tokyo Night Storm";
  };
}
