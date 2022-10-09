{
  description = "Nix flake including neovim configurations";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    utils,
    ...
  } @ inputs:
    utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      neovimBuilderWithDeps = pkgs.callPackage ./neovimBuilder.nix {
        inherit (pkgs) lib buildLuarocksPackage callPackage vimUtils nodejs neovim-unwrapped bundlerEnv ruby python3Packages writeText wrapNeovimUnstable;
        rubyPath = "${nixpkgs}/pkgs/applications/editors/neovim";
      };

      neovimConfig = neovimBuilderWithDeps.makeNeovimConfig {
        customRC = "luafile ${./settings.lua}";
        plugins = with pkgs.vimPlugins; [
          {
            plugin = nvim-treesitter.withPlugins (_: (
              pkgs.lib.subtractLists (with pkgs.tree-sitter-grammars; [
                tree-sitter-agda
                tree-sitter-kotlin
                tree-sitter-sql
                tree-sitter-verilog
              ])
              pkgs.tree-sitter.allGrammars
            ));
            config = "luafile ${./tree-sitter.lua}";
          }
          {
            plugin = catppuccin-nvim;
            config = "luafile ${./catppuccin.lua}";
          }
          {
            plugin = nvim-lspconfig;
            config = "luafile ${./lspconfig.lua}";
          }
        ];
        withNodeJs = true;
        extraRuntimeDeps = with pkgs; [
          rnix-lsp
          nodePackages.pyright
          sumneko-lua-language-server
        ];
      };
    in {
      packages.neovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig;
      checks = let
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
