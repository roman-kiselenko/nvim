vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/neovim/nvim-lspconfig",
})

require("mason").setup({
  max_concurrent_installers = 20,
  ui = {
    height = 0.8,
    icons = {
      package_installed = tools.ui.icons.bullet,
      package_pending = tools.ui.icons.ellipses,
      package_uninstalled = tools.ui.icons.open_bullet,
    },
  },
})

do
  local installed_packs = require("mason-registry").get_installed_packages()
  local lsp_config_names = vim
  .iter(installed_packs)
  :fold({}, function(acc, pack)
    table.insert(acc, pack.spec.neovim and pack.spec.neovim.lspconfig)
    return acc
  end)
  vim.lsp.enable(lsp_config_names)
end

require("mason-lspconfig").setup({
  -- Automatically install listed servers
  ensure_installed = { "gopls", "golangci_lint_ls", "yamlls" },
})
