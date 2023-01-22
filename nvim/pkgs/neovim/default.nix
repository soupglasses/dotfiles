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
      {plugin = nvim-treesitter.withAllGrammars;}
      #}
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
      # Generic
      codespell
      # Lua
      stylua
      # Nix
      alejandra
      deadnix
      statix
      # Python
      black

      # LSP servers
      elixir_ls
      nodePackages.pyright
      rnix-lsp
      rust-analyzer
      sumneko-lua-language-server
    ];
  };
in
  pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig
