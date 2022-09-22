{
  description = "My personal dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nix-index-database.url = "github:Mic92/nix-index-database";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    nixGL.url = "github:guibou/nixGL";
    nixGL.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nur, nixGL, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "sofi";

    mkPkgs = system: extras: import nixpkgs {
      inherit system;
      overlays = [ nixGL.overlays.default nur.overlay ];
    } // extras;
  in {
    packages.${system} = import ./pkgs/all-packages.nix (mkPkgs system { });
    overlays.extras = [ (final: prev: import ./pkgs/extra-packages.nix { pkgs = final; }) ];
    overlays.nixgl = [ (final: prev: import ./pkgs/nixgl-packages.nix { pkgs = final; nixgl = nixGL.packages.${final.hostPlatform.system}; }) ];

    homeConfigurations.${username} = import "${home-manager}/modules" rec {
      pkgs = (mkPkgs system {
        overlays = [ self.overlays.extras self.overlays.nixgl ];
      });
      check = true;
      configuration = {
        # Let us have a `inputs` argument inside of home-manager.
        _module.args.inputs = inputs;

        # WORKAROUND: https://github.com/nix-community/home-manager/pull/2720
        _module.args.pkgs = pkgs.lib.mkForce pkgs;
        _module.args.pkgs_i686 = pkgs.lib.mkForce { };

        imports = [
          ./home.nix
        ];

        home.homeDirectory = "/home/${username}";
        home.username = "${username}";
      };
    };

    devShells.${system}.default = let
      pkgs = nixpkgs.legacyPackages.${system};
    in pkgs.mkShell {
      buildInputs = [
        inputs.home-manager.packages.${system}.home-manager
        pkgs.nixUnstable
      ];
    }; 
  };
}
