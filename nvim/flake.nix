{
  description = "Nix flake including neovim configurations";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    supportedSystems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
    foldEachSystem = systems: f:
      builtins.foldl' nixpkgs.lib.recursiveUpdate {}
      (nixpkgs.lib.forEach systems f);
  in
    foldEachSystem supportedSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system} = import ./pkgs {inherit pkgs;};
      overlays.default = final: _prev: {nvim = self.packages.${final.system}.neovim;};
    });
}
