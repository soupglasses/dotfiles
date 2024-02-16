{
  description = "My personal dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nix-index-database.url = "github:Mic92/nix-index-database";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixGL.url = "github:guibou/nixGL";
    nixGL.inputs.nixpkgs.follows = "nixpkgs";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, nixGL, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "sofi";
    my_pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.permittedInsecurePackages = [
        "electron-25.9.0"
      ];
      overlays = [ self.overlays.default self.overlays.nixgld nixGL.overlays.default ];
    };
  in {
    packages."x86_64-linux" = import ./packages/default.nix { pkgs = nixpkgs.legacyPackages."x86_64-linux"; };
    packages."aarch64-linux" = import ./packages/default.nix { pkgs = nixpkgs.legacyPackages."aarch64-linux"; };

    overlays.default = (_final: prev: import ./packages/default.nix { pkgs = prev; });
    overlays.nixgld = (_final: prev: { nixgld = import ./packages/nixgl-packages.nix { pkgs = prev; nixgl = nixGL.packages.${prev.system}; }; });

    homeConfigurations.${username} = import "${home-manager}/modules" rec {
      pkgs = my_pkgs;
      check = true;
      configuration = {
        # Let us have a `inputs` argument inside of home-manager.
        _module.args.inputs = inputs;
        _module.args.system = system;

        # WORKAROUND: https://github.com/nix-community/home-manager/pull/2720
        _module.args.pkgs = nixpkgs.lib.mkForce pkgs;
        _module.args.pkgs_i686 = nixpkgs.lib.mkForce { };

        imports = [
          ./home/default.nix
        ];

        home.homeDirectory = "/home/${username}";
        home.username = "${username}";
      };
    };

    devShells.${system}.default = let pkgs = my_pkgs; in pkgs.mkShell {
      buildInputs = [
        inputs.home-manager.packages.${system}.home-manager
        pkgs.nixUnstable
      ];
    };
  };
}
