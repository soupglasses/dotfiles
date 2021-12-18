{ self, pkgs, ... }: 
let
  lib = self.inputs.digga.lib;
in
{
  imports = [ (lib.importExportableModules ./modules) ];

  home.packages = with pkgs; [
    fzf
    deltachat-desktop
    git
    gcc
    tree-sitter
    grc
    httpie
    kitty
    multimc
    neofetch
    python39
    python39Packages.ipython
    ripgrep
    stow
    sqlite
    tealdeer
    tree
    trash-cli
    toilet
    unzip
    youtube-dl
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      . ~/.dotfiles/configs/zsh/.zshrc
    '';
  };
}

