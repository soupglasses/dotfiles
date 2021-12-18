{
  description = "My personal NixOS configuration";
  
  nixConfig.extra-experimental-features = "nix-command flakes";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/release-21.11";
    latest.url = "github:nixos/nixpkgs/nixos-unstable";

    home.url = "github:nix-community/home-manager/release-21.11";
    home.inputs.nixpkgs.follows = "nixos";

    digga.url = "github:divnix/digga";
    digga.inputs.nixpkgs.follows = "nixos";
    digga.inputs.home-manager.follows = "home";

    sops.url = "github:Mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "nixos";

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    { self
    , nixos
    , latest
    , home
    , digga
    , sops
    , hardware } @ inputs:
      digga.lib.mkFlake {
        inherit self inputs;

        channels = {
          nixos = { };
        };

        nixos = ./nixos;
        home = ./home;
      };
}
