{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    rust-overlay.url = "github:oxalica/rust-overlay";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";


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

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    { self, nixpkgs, nixpkgs-stable, chaotic, nixos-cli, home-manager, nixos-hardware, rust-overlay, kmonad, ... }@inputs:
    let inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; allowUnfreePredicate = (_: true); }; };
      pkgs-stable = import nixpkgs-stable { inherit system; config = { allowUnfree = true; allowUnfreePredicate = (_: true); }; };

      overlays = [
        rust-overlay.overlays.default
      ];
    in
    {
      nixosConfigurations = {
        "raf-x570" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          specialArgs = { inherit pkgs-stable; };
          modules = [
            ./hosts/raf-x570/configuration.nix
            chaotic.nixosModules.default
            nixos-cli.nixosModules.nixos-cli
            ({ pkgs, ... }: {
              nixpkgs.overlays = overlays;
            })
            kmonad.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        "raf@raf-x570" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home/home.nix
            ({ pkgs, ... }: {
              nixpkgs.overlays = overlays;
            })
          ];
        };
      };
    };
}
