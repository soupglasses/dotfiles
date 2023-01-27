{ pkgs, ... }: {
  neovim = import ./neovim/default.nix { inherit pkgs; };
}
