require("oil").setup()

require("techbase").setup({
  transparent = true
})

require('go').setup({
  goimports ='gopls',
  gofmt = 'gofumpt'
})

require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    html = { "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    go = { "goimports" },
  },
})

vim.schedule(function()
  vim.cmd.packadd("which-key.nvim")
  local wk = require("which-key")
  wk.setup({
    delay = 500,
    icons = {
      separator = "→",
      mappings = false,
    },
    layout = { align = "center" },
    triggers = {
      { "<leader>", mode = { "n", "v" } },
    },
    plugins = {
      spelling = {
        enabled = false,
      },
    },
    preset = "classic",
  })

  vim.api.nvim_set_hl(0, "WhichKeyValue", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "WhichKeyDesc", { link = "NormalFloat" })
end)

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

require("mini.icons").setup((function()
  local mini = require("mini.icons")

  local make_icon_tbl = function(category)
    local res = {}
    local postfix = "  "

    for _, name in ipairs(mini.list(category)) do
      res[name] = { glyph = " " .. mini.get(category, name) .. postfix }
    end

    return res
  end

  local default_icon = { glyph = "   " }

  local defaults = make_icon_tbl("default")
  defaults.extension = default_icon
  defaults.file = default_icon
  defaults.filetype = default_icon

  local file_icons = make_icon_tbl("file")
  file_icons[".zshrc"] = { glyph = " 󰒓  " }
  file_icons["init.lua"] = { glyph = " 󰢱  ", hl = "MiniIconsAzure" }
  file_icons["README.md"] = { glyph = "   ", hl = "MiniIconsCyan" }

  local ft_icons = make_icon_tbl("filetype")
  ft_icons.dosini = default_icon
  ft_icons.text = default_icon

  return {
    default = defaults,
    directory = make_icon_tbl("directory"),
    extension = make_icon_tbl("extension"),
    file = file_icons,
    filetype = ft_icons,
    lsp = make_icon_tbl("lsp"),
  }
end)())

require("gitsigns").setup({
  attach_to_untracked = false,
  preview_config = {
    border = "solid",
    row = 1,
    col = 1,
  },
  signcolumn = true,
  signs = {
    change = { text = " ┋" },
  },
  signs_staged = {
    change = { text = " ┋" },
  },
  update_debounce = 500,
})

local actions = require("fzf-lua.actions")
local fzf = require("fzf-lua")
-- --
fzf.setup({
  actions = {
    files = {
      ["enter"] = actions.file_edit,
    },
  },
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    },
  },
  buffers = {
    cwd_prompt = false,
    ignore_current_buffer = true,
    prompt = "Buffers: ",
  },
  files = {
    cwd_prompt = false,
    prompt = "Files: ",
    formatter = "path.filename_first",
  },
  grep = {
    cmd = "rg -o -n -r '' --column --no-heading --smart-case",
    prompt = "Text: ",
  },
  lsp = {
    prompt_postfix = ": ",
  },
  defaults = {
    git_icons = false,
  },
  fzf_colors = {
    ["bg"] = { "bg", "NormalFloat" },
    ["bg+"] = { "bg", "CursorLine" },
    ["fg"] = { "fg", "Comment" },
    ["fg+"] = { "fg", "Normal" },
    ["hl"] = { "fg", "CmpItemAbbrMatch" },
    ["hl+"] = { "fg", "CmpItemAbbrMatch" },
    ["gutter"] = { "bg", "NormalFloat" },
    ["header"] = { "fg", "NonText" },
    ["info"] = { "fg", "NonText" },
    ["pointer"] = { "bg", "Cursor" },
    ["separator"] = { "bg", "NormalFloat" },
    ["spinner"] = { "fg", "NonText" },
  },
  fzf_opts = { ["--keep-right"] = "" },
  hls = {
    border = "FloatBorder",
    header_bind = "NonText",
    header_text = "NonText",
    help_normal = "NonText",
    normal = "NormalFloat",
    preview_border = "FloatBorder",
    preview_normal = "NormalFloat",
    search = "CmpItemAbbrMatch",
    title = "FloatTitle",
  },
  winopts = {
    backdrop = 90,
    cursorline = true,
    height = 0.75,
    width = 0.93,
    row = 0.5,
    preview = {
      layout = "horizontal",
      scrollbar = "border",
      vertical = "up:65%",
    },
  },
})

fzf.register_ui_select()

require("tiny-glimmer").setup({
  refresh_interval_ms = 1,
  overwrite = {
    paste = {
      enabled = true,
      default_animation = {
        name = "fade",
        settings = {
          from_color = "CurSearch",
        },
      },
    },
    undo = {
      enabled = true,
      default_animation = {
        name = "fade",
        settings = {
          from_color = "DiffDelete",
        },
      },
    },
    redo = {
      enabled = true,
      default_animation = {
        name = "fade",
        settings = {
          from_color = "DiffAdd",
        },
      },
    },
  },
  animations = {
    fade = {
      to_color = "Normal",
      min_duration = 300,
      max_duration = 300,
      chars_for_max_duration = 1,
    },
    left_to_right = {
      to_color = "Normal",
      min_duration = 300,
      max_duration = 300,
      chars_for_max_duration = 1,
    },
  },
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

require("fidget").setup({
  progress = {
    suppress_on_insert = true,
    display = {
      done_ttl = 2,
      done_icon = tools.ui.icons.ok,
      progress_icon = {
        pattern = {
          " 󰫃 ",
          " 󰫄 ",
          " 󰫅 ",
          " 󰫆 ",
          " 󰫇 ",
          " 󰫈 ",
        },
      },
      done_style = "Comment",
      group_style = "Comment",
      icon_style = "Comment",
      progress_style = "Comment",
    },
  },
  notification = {
    window = {
      border_hl = "Comment",
      normal_hl = "Comment",
      winblend = 100,
      border = "solid",
      relative = "win",
    },
  },
})

require("origami").setup()

require("hlslens").setup({
  calm_down = true,
  enable_incsearch = false,
  override_lens = tools.lens,
})
