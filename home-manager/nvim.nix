{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    (rust-bin.stable.latest.default.override { extensions = [ "rust-src" ]; })

    #language servers
    nil
    gopls
    nodePackages_latest.bash-language-server
    ruff-lsp
    lua-language-server
    neocmakelsp
    taplo

    #formatters
    alejandra
    nixfmt
    nixpkgs-fmt
    beautysh
    stylua
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      gcc
      gnumake
      unzip
      p7zip
      ripgrep
      fzf
      vimPlugins.telescope-fzf-native-nvim
      xclip
      wl-clipboard
    ];
  };
}
