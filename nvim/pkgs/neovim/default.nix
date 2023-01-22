{
  pkgs,
  inputs,
  ...
}: let
  neovimBuilderWithDeps = pkgs.callPackage ./neovimBuilder.nix {
    inherit (pkgs) buildLuarocksPackage;
    rubyPath = "${inputs.nixpkgs}/pkgs/applications/editors/neovim";
  };

  neovimConfig = neovimBuilderWithDeps.makeNeovimConfig {
    customRC = ''
      lua << EOF
        -- Remove per user configuration
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
      {plugin = vim-pandoc-syntax;}
      {
        plugin = nvim-treesitter.withPlugins (g: [
          g.tree-sitter-dockerfile
          g.tree-sitter-dot
          g.tree-sitter-bibtex
          g.tree-sitter-rust
          g.tree-sitter-zig
          g.tree-sitter-ledger
          g.tree-sitter-cmake
          g.tree-sitter-json5
          g.tree-sitter-gomod
          g.tree-sitter-gowork
          g.tree-sitter-ruby
          g.tree-sitter-llvm
          g.tree-sitter-perl
          g.tree-sitter-http
          g.tree-sitter-rego
          g.tree-sitter-fish
          g.tree-sitter-make
          g.tree-sitter-php
          g.tree-sitter-java
          g.tree-sitter-norg
          g.tree-sitter-julia
          g.tree-sitter-jsonnet
          g.tree-sitter-erlang
          g.tree-sitter-elixir
          g.tree-sitter-surface
          g.tree-sitter-eex
          g.tree-sitter-ocaml
          g.tree-sitter-org
          g.tree-sitter-tiger
          g.tree-sitter-nix
          g.tree-sitter-scala
          g.tree-sitter-regex
          g.tree-sitter-r
          g.tree-sitter-haskell
          g.tree-sitter-vim
          g.tree-sitter-markdown_inline
          g.tree-sitter-tlaplus
          g.tree-sitter-lua
          g.tree-sitter-toml
          g.tree-sitter-pug
          g.tree-sitter-elm
          g.tree-sitter-yang
          g.tree-sitter-dart
          g.tree-sitter-rst
          g.tree-sitter-fennel
          g.tree-sitter-vue
          g.tree-sitter-css
          g.tree-sitter-c
          g.tree-sitter-query
          g.tree-sitter-html
          g.tree-sitter-yaml
          g.tree-sitter-graphql
          g.tree-sitter-bash
          g.tree-sitter-tsx
          g.tree-sitter-hcl
          g.tree-sitter-glimmer
          g.tree-sitter-latex
          g.tree-sitter-c_sharp
          g.tree-sitter-go
          g.tree-sitter-scheme
          g.tree-sitter-nickel
          g.tree-sitter-comment
          g.tree-sitter-typescript
          g.tree-sitter-jsdoc
          g.tree-sitter-glsl
          g.tree-sitter-json
          g.tree-sitter-hjson
          g.tree-sitter-sparql
          g.tree-sitter-heex
          g.tree-sitter-javascript
          g.tree-sitter-gdscript
          g.tree-sitter-embedded_template
          g.tree-sitter-python
          g.tree-sitter-scss
          g.tree-sitter-clojure
          g.tree-sitter-supercollider
          g.tree-sitter-ql
          g.tree-sitter-commonlisp
          g.tree-sitter-turtle
          g.tree-sitter-ocaml_interface
          g.tree-sitter-cpp
          g.tree-sitter-pioasm
          g.tree-sitter-svelte
          g.tree-sitter-prisma
          g.tree-sitter-fortran
          g.tree-sitter-beancount
          g.tree-sitter-markdown
        ]);
      }
      # Themes
      {plugin = catppuccin-nvim;}

      # UI
      {plugin = indent-blankline-nvim;}

      # Dependencies
      {plugin = plenary-nvim;} # For: null-ls-nvim

      # LSP
      {plugin = nvim-lspconfig;}
      {plugin = nvim-cmp;}
      {plugin = cmp-nvim-lua;}
      {plugin = cmp-nvim-lsp;}
      {plugin = null-ls-nvim;}
    ];
    withRuby = false;
    withNodeJs = false;
    withPython3 = false;
    extraRuntimeDeps = with pkgs; [
      alejandra
      black
      deadnix
      nodePackages.prettier
      statix
      stylua

      rnix-lsp
      nodePackages.pyright
      sumneko-lua-language-server
      rust-analyzer
    ];
  };
in
  pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig
