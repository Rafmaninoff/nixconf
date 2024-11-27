{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware/1b0b927860d7eb367ee6a3123ddeb7a8e24bd836";
    rust-overlay.url = "github:oxalica/rust-overlay";
    chaotic.url = "github:chaotic-cx/nyx/99820d0879145c40652598a80540692505eebb23";

    #TODO: switch back to upstream gmodena/nix-flatpak once the lib.mdDoc issue is resolved
    nix-flatpak.url = "github:rafmaninoff/nix-flatpak";

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
