# Act like nixpkgs for update scripts.
# Inspired by https://github.com/jtojnar/nixfiles/blob/master/default.nix
{...}:
let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  flake-compat = fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
    sha256 = lock.nodes.flake-compat.locked.narHash;
  };
  self = import flake-compat {
    src = ./.;
  };

  packages = self.defaultNix.outputs.legacyPackages.${builtins.currentSystem};
in
packages # Prepend all packages to the top level, mimmicing nixpkgs.
// self.defaultNix # Append flake-compat's arguments that follow flake formatting.
