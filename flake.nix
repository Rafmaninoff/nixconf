{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    nur.url = "github:nix-community/nur";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    #home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
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

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      chaotic,
      nixos-cli,
      home-manager,
      nixos-hardware,
      rust-overlay,
      nur,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
          AllowUnfreePredicate = (_: true);
        };
      };
      overlays = [ rust-overlay.overlays.default ];
    in
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        "raf-x570" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          specialArgs = {
            inherit pkgs-stable;
          };
          # > Our main nixos configuration file <
          modules = [
            ./hosts/raf-x570/configuration.nix
            chaotic.nixosModules.default
            nixos-cli.nixosModules.nixos-cli
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = overlays;
              }
            )
            nur.nixosModules.nur
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "raf@raf-x570" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          # > Our main home-manager configuration file <
          modules = [
            ./home/home.nix
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = overlays;
              }
            )
          ];
        };
      };
    };
}
