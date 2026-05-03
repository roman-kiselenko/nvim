return {
  -- on_attach = function ()
  --   print("gopls attached")
  -- end,
  -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
  settings = {
    ['gopls'] = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      completeUnimported = true,
      usePlaceholders = true,
    },
  },
}
