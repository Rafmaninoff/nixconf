{ pkgs, lib, config, ... }: {

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      (rust-bin.stable.latest.default.override {
        extensions = [ "rust-src" "rust-analyzer" "rustfmt" "clippy" ];
      })
      lua5_1
      lua51Packages.luarocks-nix
      gcc
      gnumake
      unzip
      p7zip
      ripgrep
      fzf
      vimPlugins.telescope-fzf-native-nvim
      xclip
      wl-clipboard
      texlive.combined.scheme-full
      tree-sitter
      nodejs
      go
      gotools

      #language servers
      nil
      gopls
      bash-language-server
      pyright
      ruff-lsp
      lua-language-server
      yaml-language-server
      neocmakelsp
      taplo
      texlab
      haskell-language-server
      haskellPackages.hoogle
      haskellPackages.fast-tags
      haskellPackages.haskell-debug-adapter
      haskellPackages.ghci-dap

      #formatters
      alejandra
      nixfmt-classic
      nixpkgs-fmt
      beautysh
      stylua
      gofumpt
      markdownlint-cli2
      prettierd
      shfmt
    ];

    plugins = with pkgs.vimPlugins; [ markdown-preview-nvim ];

  };
}
