{
  description = "My NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-25.11";

    nixos-hardware.url =
      "github:8bitbuddhist/nixos-hardware?ref=surface-kernel-6.18";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cli = {
      url = "github:water-sucks/nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs:
    let
      system = "x86_64-linux";
      myOverlays = [ inputs.rust-overlay.overlays.default ];
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = myOverlays;
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = { allowUnfree = true; };
      };
    in {
      nixosConfigurations = {
        "sb2" = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs-stable; };
          modules = [
            ./hosts/sb2/configuration.nix
            inputs.disko.nixosModules.disko
            inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.nixos-cli.nixosModules.nixos-cli
            inputs.chaotic.nixosModules.default
          ];
        };
        "raf-x570" = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs-stable; };
          modules = [
            ./hosts/raf-x570/configuration.nix
            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.nixos-cli.nixosModules.nixos-cli
            inputs.chaotic.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        "raf@sb2" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/home.nix ];
        };

        "raf@raf-x570" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/home.nix ];
        };
      };
    };
}
