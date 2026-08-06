{
  description = "NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "nixpkgs/nixos-26.11";
    nixpkgs.url = "nixpkgs/nixos-26.05";
    # nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
      # url = "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      katana = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
