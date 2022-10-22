{ pkgs, inputs, ... }:
let
  neovimBuilderWithDeps = pkgs.callPackage ./neovimBuilder.nix {
    inherit (pkgs) buildLuarocksPackage;
    rubyPath = "${inputs.nixpkgs}/pkgs/applications/editors/neovim";
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
        config = "luafile ${./plugins/catppuccin.lua}";
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
in
pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig
