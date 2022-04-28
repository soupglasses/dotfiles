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
        (final: prev: { home-manager = home-manager.packages.${prev.system}.home-manager; })
      ];
    };
    lib = pkgs.lib;
  in {
    # WORKAROUND: https://github.com/nix-community/home-manager/pull/2720
    homeConfigurations.${username} = import "${home-manager}/modules" {
      inherit pkgs;
      check = true;
      configuration = {
        _module.args.pkgs = lib.mkForce pkgs;
        _module.args.pkgs_i686 = lib.mkForce { };
        imports = [ ./home.nix ];
        home.homeDirectory = "/home/${username}";
        home.username = "${username}";
      };
    };

    devShell.${system} = pkgs.mkShell {
      buildInputs = [
        pkgs.home-manager
        pkgs.nixUnstable
      ];
    }; 
  };
}
