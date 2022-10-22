{ pkgs, inputs, ... }: {
  neovim = import ./neovim/default.nix { inherit pkgs inputs; };
}
