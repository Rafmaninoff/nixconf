{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/4aa36568d413aca0ea84a1684d2d46f55dbabad7";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    rust-overlay.url = "github:oxalica/rust-overlay";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    arrpc = {
      url = "github:notashelf/arrpc-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cli = {
      url = "github:water-sucks/nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kmonad = {
      url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    { self, nixpkgs, nixpkgs-stable, chaotic, nixos-cli, home-manager, nixos-hardware, rust-overlay, kmonad, ... }@inputs:
    let inherit (self) outputs;
      system = "x86_64-linux";
      myOverlays = [
        rust-overlay.overlays.default
      ];

      pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; overlays = myOverlays; };
      pkgs-stable = import nixpkgs-stable { inherit system; config = { allowUnfree = true; }; overlays = myOverlays; };

    in
    {
      nixosConfigurations = {
        "raf-x570" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; inherit pkgs-stable; };
          modules = [
            ./hosts/raf-x570/configuration.nix
            chaotic.nixosModules.default
            nixos-cli.nixosModules.nixos-cli
            # kmonad.nixosModules.default
            inputs.nix-flatpak.nixosModules.nix-flatpak
          ];
        };
        "sb2" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; inherit pkgs-stable; };
          modules = [
            ./hosts/sb2/configuration.nix
            chaotic.nixosModules.default
            nixos-cli.nixosModules.nixos-cli
            # kmonad.nixosModules.default
            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
          ];
        };
      };

      homeConfigurations = {
        "raf@raf-x570" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home/home.nix
          ];
        };

        "raf@sb2" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home/home.nix
          ];
        };
      };
    };
}
