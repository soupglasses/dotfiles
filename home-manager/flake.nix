{
  description = "My personal dotfiles";

  nixConfig.extra-experimental-features = "nix-command flakes";
  nixConfig.extra-substituters = "https://imsofi.cachix.org https://nix-community.cachix.org";
  nixConfig.extra-trusted-public-keys = "imsofi.cachix.org-1:KsqZ5nGoUfMHwzCGFnmTLMukGp7Emlrz/OE9Izq/nEM= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    imsofi-nur = {
      url = "github:imsofi/nur-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "sofi";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "geogebra"
        ];
      };

      overlays = [
        (final: prev: { home-manager = inputs.home-manager.packages.${prev.system}.home-manager; })
        (final: prev: { ferium = inputs.imsofi-nur.packages.${prev.system}.ferium; })
      ];
    };
    lib = pkgs.lib;
  in {
    homeConfigurations.${username} = import "${home-manager}/modules" {
      inherit pkgs;
      check = true;
      configuration = {
        # Let us have a `inputs` argument inside of home-manager.
        _module.args.inputs = inputs;

        # WORKAROUND: https://github.com/nix-community/home-manager/pull/2720
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
