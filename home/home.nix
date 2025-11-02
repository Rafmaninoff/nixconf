# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # inputs.arrpc.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./nvim.nix
    ./zsh.nix
    ./kitty.nix
    homeModules/cli
    homeModules/apps
  ];

  home = {
    username = "raf";
    homeDirectory = "/home/raf";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    vesktop
    eza
    bat
    fd
    fzf
    fzy
    lazygit
    gh
    yadm
    ripgrep
  ];

  xdg.enable = true;

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      key = null;
      signByDefault = true;
      format = "openpgp";
    };
    settings = {
      user.email = "rafmaninoff@gmail.com";
      user.name = "Rafael Uria";
      init.defaultBranch = "main";
    };
  };

  programs.zellij = { enable = false; };

  programs.zoxide = { enable = true; enableZshIntegration = true; };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    pinentry.package = pkgs.pinentry-qt;
    extraConfig = ''
    '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
