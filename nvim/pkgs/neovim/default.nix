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

      set runtimepath^=${./config}
      set runtimepath+=${./config}/after
      luafile ${./config}/init.lua
    '';
    plugins = with pkgs.vimPlugins; [
      # Syntax
      { plugin = vim-pandoc-syntax; }
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
      # Themes
      { plugin = catppuccin-nvim; }

      # UI
      { plugin = indent-blankline-nvim; }

      # Dependencies
      { plugin = plenary-nvim; } # For: null-ls-nvim

      # LSP
      { plugin = nvim-lspconfig; }
      { plugin = nvim-cmp; }
      { plugin = cmp-nvim-lua; }
      { plugin = cmp-nvim-lsp; }
      { plugin = null-ls-nvim; }
    ];
    withNodeJs = true;
    extraRuntimeDeps = with pkgs; [
      alejandra
      deadnix
      rnix-lsp
      nodePackages.pyright
      sumneko-lua-language-server
      rust-analyzer
    ];
  };
in
pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig
