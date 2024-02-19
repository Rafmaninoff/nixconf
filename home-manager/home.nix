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
    ./direnv.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

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
  ];


  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "rafmaninoff@gmail.com";
    userName = "Rafael Uria";
    signing = {
      key = null;
      signByDefault = true;
    };
  };

  programs.zellij = { enable = true; };

  programs.zoxide = { enable = true; enableZshIntegration = true; };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    pinentryFlavor = "qt";
    extraConfig = ''
      keyserver hkps://keyserver.ubuntu.com
    '';
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
