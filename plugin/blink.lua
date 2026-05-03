vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") }
})

require("blink.cmp").setup({
  sources = {
    default = { "lsp", "snippets", "path", "buffer" },
    providers = {
      buffer = {
        name = "buffer",
        max_items = 4,
      },
      lsp = {
        name = "LSP",
      },
      path = {
        name = "path",
        opts = {
          get_cwd = function(_) return vim.fn.getcwd() end,
        },
      },
      snippets = {
        name = "snippets",
      },
    },
  },
  cmdline = {
    keymap = {
      ["<Tab>"] = { "select_and_accept" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
    },
    completion = {
      menu = { auto_show = true },
    },
  },
  keymap = {
    ["<Tab>"] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      "snippet_forward",
      "fallback",
    },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<Up>"] = { "fallback" },
    ["<Down>"] = { "fallback" },
  },
  completion = {
    keyword = {
      range = "full",
    },
    list = {
      selection = { preselect = true, auto_insert = false },
    },
    documentation = {
      window = {
        border = "rounded",
        min_width = 20,
        max_width = 100,
      },
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    menu = {
      min_width = 34,
      max_height = 10,
      draw = {
        treesitter = { "lsp" },
        align_to = "cursor",
        padding = 1,
        gap = 3,
        columns = {
          { "kind_icon", gap = 1, "label" },
          { "label_description" },
        },
        components = {
          kind_icon = {
            ellipsis = false,
            text = function(ctx) return ctx.kind_icon end,
            highlight = function(ctx) return "BlinkCmpKind" .. ctx.kind end,
          },
          label = {
            width = {
              fill = true,
              max = 60,
            },
            text = function(ctx) return ctx.label .. ctx.label_detail end,
            highlight = function(ctx)
              local highlights = {
                {
                  0,
                  #ctx.label,
                  group = ctx.deprecated and "BlinkCmpLabelDeprecated"
                    or "BlinkCmpLabel",
                },
              }
              if ctx.label_detail then
                table.insert(highlights, {
                  #ctx.label,
                  #ctx.label + #ctx.label_detail,
                  group = "BlinkCmpLabelDetail",
                })
              end

              for _, idx in ipairs(ctx.label_matched_indices) do
                table.insert(
                  highlights,
                  { idx, idx + 1, group = "BlinkCmpLabelMatch" }
                )
              end

              return highlights
            end,
          },
          label_description = {
            text = function(ctx) return tools.get_lsp_completion_context(ctx.item) end,
            highlight = "BlinkCmpLabelDescription",
          },
        },
      },
    },
  },
  appearance = {
    nerd_font_variant = "mono",
    kind_icons = tools.ui.kind_icons_spaced,
  },
})
