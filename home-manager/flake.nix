{
  description = "My personal dotfiles";

  nixConfig.extra-experimental-features = "nix-command flakes";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "sofi";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (final: prev: { home-manager = inputs.home-manager.packages.${prev.system}.home-manager; })
      ];
    };
  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit system username pkgs;
      configuration = import ./home.nix;
      homeDirectory = "/home/${username}";
      stateVersion = "21.11";
    };

    devShell.${system} = pkgs.mkShell {
      buildInputs = [
        pkgs.home-manager
        pkgs.nixUnstable
      ];
    }; 
  };
}
