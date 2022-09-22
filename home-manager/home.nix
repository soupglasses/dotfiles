{ lib, pkgs, config, ... }:
{
  imports = [
    # Setup
    ./modules/nix-settings.nix
    ./modules/generic-linux
    # Configure
    ./modules/terminal
    # Tools
    ./modules/tools/comma.nix
    ./modules/tools/git.nix
    ./modules/tools/gpg.nix
    ./modules/tools/navi
    # Gui
    ./modules/gnome
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    # Requirements
    home-manager
    # Cli
    asciinema
    ferium
    glow
    tree
    trash-cli
    gh
    # Gui
    apache-directory-studio
    geogebra
  ]; ++ (if config.targets.genericLinux.enable then [
    nixgld.kitty
  ] else [
    kitty
  ]);

  home.stateVersion = "21.11";
}
