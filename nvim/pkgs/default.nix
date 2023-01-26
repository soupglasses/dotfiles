{ pkgs, nixpkgs, ... }: {
  neovim = import ./neovim/default.nix { inherit pkgs nixpkgs; };
}
