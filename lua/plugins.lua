-- INFO: completion engine
local GH = function(repo) return "https://github.com/" .. repo end

vim.pack.add({
  GH("ray-x/go.nvim"),
  GH("ray-x/guihua.lua"),
  GH("mason-org/mason.nvim"),
  GH("neovim/nvim-lspconfig"),
  GH("mcauley-penney/techbase.nvim"),
  GH("stevearc/conform.nvim"),
  GH("chrisgrieser/nvim-origami"),
  GH("kevinhwang91/nvim-hlslens"),
  GH("stevearc/oil.nvim"),
  GH("echasnovski/mini.icons"),
  GH("kdheepak/lazygit.nvim"),
  GH("lewis6991/gitsigns.nvim"),
  { src = GH("folke/which-key.nvim"), confirm = false },
  GH("ibhagwan/fzf-lua"),
  GH("j-hui/fidget.nvim"),
  GH("rachartier/tiny-glimmer.nvim"),
  { src = GH("saghen/blink.cmp"), version = vim.version.range("1.x") },
})
