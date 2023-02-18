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
      checks.${system} = let
        nmt = pkgs.fetchFromGitLab {
          owner = "rycee";
          repo = "nmt";
          rev = "d2cc8c1042b1c2511f68f40e2790a8c0e29eeb42";
          sha256 = "1ykcvyx82nhdq167kbnpgwkgjib8ii7c92y3427v986n2s5lsskc";
        };
        runTest = neovim-drv: buildCommand:
          pkgs.runCommandLocal "test-${neovim-drv.name}" {
            nativeBuildInputs = [];
            meta.platforms = neovim-drv.meta.platforms;
          } (''
              source ${nmt}/bash-lib/assertions.sh
              vimrc="${pkgs.writeText "init.vim" neovim-drv.initRc}"
              vimrcGeneric="$out/patched.vim"
              mkdir $out
              ${pkgs.perl}/bin/perl -pe "s|\Q$NIX_STORE\E/[a-z0-9]{32}-|$NIX_STORE/eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee-|g" < "$vimrc" > "$vimrcGeneric"
            ''
            + buildCommand);
      in {
        neovim = runTest self.packages.${system}.neovim ''
          export HOME=$TMPDIR
          ${self.packages.${system}.neovim}/bin/nvim -i NONE +quit! -e
        '';
      };
    });
}
