{ pkgs }:
{
  nvim = pkgs.callPackage ./neovim { };
  ps3iso-utils = pkgs.callPackage ./ps3iso-utils { };
}
