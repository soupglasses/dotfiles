{ self, inputs, ... }:
let
  inherit (inputs.digga.lib) allProfilesTest;
in
{
  hostDefaults.channelName = "nixos";
  hostDefaults.system = "x86_64-linux";
  hosts = {
    laptop.modules = [
      inputs.hardware.nixosModules.lenovo-thinkpad-t460
      inputs.sops.nixosModules.sops
      ./laptop/configuration.nix
    ];
  };
  importables = rec {
    suits = rec {
      base = [ ];
    };
  };
}
