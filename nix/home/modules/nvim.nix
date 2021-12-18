{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    neovim
    python-language-server
  ];

  xdg.configFile."nvim" = {
    source = ../../../configs/nvim/.config/nvim;
    recursive = true;
  };
}
