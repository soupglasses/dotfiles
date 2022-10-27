{ pkgs, inputs, ... }:
let
  neovimBuilderWithDeps = pkgs.callPackage ./neovimBuilder.nix {
    inherit (pkgs) buildLuarocksPackage;
    rubyPath = "${inputs.nixpkgs}/pkgs/applications/editors/neovim";
  };

  neovimConfig = neovimBuilderWithDeps.makeNeovimConfig {
    customRC = ''
      lua << EOF
        vim.opt.rtp:remove(table.concat({vim.call("stdpath", "data"), "site"}, "/"))
        vim.opt.rtp:remove(table.concat({vim.call("stdpath", "data"), "site", "after"}, "/"))
        vim.opt.rtp:remove(vim.call("stdpath", "config"))
        vim.opt.rtp:remove(table.concat({vim.call("stdpath", "config"), "after"}, "/"))

        vim.cmd [[let &packpath = &runtimepath]]
      EOF

      luafile ${./settings.lua}
      luafile ${./tree-sitter.lua}
      luafile ${./plugins/catppuccin.lua}
      luafile ${./lspconfig.lua}
      luafile ${./lsplines.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withPlugins (_: (
          pkgs.lib.subtractLists (with pkgs.tree-sitter-grammars; [
            tree-sitter-agda
            tree-sitter-cuda
            tree-sitter-kotlin
            tree-sitter-sql
            tree-sitter-verilog
            tree-sitter-ql-dbscheme
            tree-sitter-fluent
          ])
          pkgs.tree-sitter.allGrammars
        ));
      }
      {
        plugin = catppuccin-nvim;
      }
      {
        plugin = nvim-lspconfig;
      }
      {
        plugin = lsp_lines-nvim;
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
