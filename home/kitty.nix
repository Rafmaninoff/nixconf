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

      #I don't want to confirm closing.
      confirm_os_window_close = 0;

      strip_trailing_spaces = "smart";

      placement_strategy = "center";

      window_padding_width = 2;

    };
    theme = "Tokyo Night";
  };
}
