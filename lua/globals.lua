_G.tools = {
  ui = {
    icons = {
      branch = "",
      bullet = "•",
      open_bullet = "○",
      ok = "✔",
      d_chev = "v",
      ellipses = "…",
      node = "╼",
      document = "≡",
      lock = "",
      r_chev = ">",
      warning = " ",
      error = " ",
      info = "󰌶 ",
    },
    kind_icons = {
      Array = " 󰅪 ",
      BlockMappingPair = " 󰅩 ",
      Boolean = "  ",
      BreakStatement = " 󰙧 ",
      Call = " 󰃷 ",
      CaseStatement = " 󰨚 ",
      Class = "  ",
      Color = "  ",
      Constant = "  ",
      Constructor = " 󰆧 ",
      ContinueStatement = "  ",
      Copilot = "  ",
      Declaration = " 󰙠 ",
      Delete = " 󰩺 ",
      DoStatement = " 󰑖 ",
      Element = " 󰅩 ",
      Enum = "  ",
      EnumMember = "  ",
      Event = "  ",
      Field = "  ",
      File = "  ",
      Folder = "  ",
      ForStatement = "󰑖 ",
      Function = " 󰆧 ",
      GotoStatement = " 󰁔 ",
      Identifier = " 󰀫 ",
      IfStatement = " 󰇉 ",
      Interface = "  ",
      Keyword = "  ",
      List = " 󰅪 ",
      Log = " 󰦪 ",
      Lsp = "  ",
      Macro = " 󰁌 ",
      MarkdownH1 = " 󰉫 ",
      MarkdownH2 = " 󰉬 ",
      MarkdownH3 = " 󰉭 ",
      MarkdownH4 = " 󰉮 ",
      MarkdownH5 = " 󰉯 ",
      MarkdownH6 = " 󰉰 ",
      Method = " 󰆧 ",
      Module = " 󰅩 ",
      Namespace = " 󰅩 ",
      Null = " 󰢤 ",
      Number = " 󰎠 ",
      Object = " 󰅩 ",
      Operator = "  ",
      Package = " 󰆧 ",
      Pair = " 󰅪 ",
      Property = "  ",
      Reference = "  ",
      Regex = "  ",
      Repeat = " 󰑖 ",
      Return = " 󰌑 ",
      RuleSet = " 󰅩 ",
      Scope = " 󰅩 ",
      Section = " 󰅩 ",
      Snippet = "  ",
      Specifier = " 󰦪 ",
      Statement = " 󰅩 ",
      String = "  ",
      Struct = "  ",
      SwitchStatement = " 󰨙 ",
      Table = " 󰅩 ",
      Terminal = "  ",
      Text = " 󰀬 ",
      Type = "  ",
      TypeParameter = "  ",
      Unit = "  ",
      Value = "  ",
      Variable = "  ",
      WhileStatement = " 󰑖 ",
    },
  },
  nonprog_modes = {
    ["markdown"] = true,
    ["org"] = true,
    ["orgagenda"] = true,
    ["text"] = true,
  },
}

local icons_spaced = {}
for key, value in pairs(_G.tools.ui.kind_icons) do
  icons_spaced[key] = value .. " "
end

_G.tools.ui.kind_icons_spaced = icons_spaced

tools.get_path_root = function(path)
  if path == "" then return end

  local root = vim.b.path_root
  if root then return root end

  local root_items = {
    ".git",
    "go.mod",
  }

  root = vim.fs.root(path, root_items)
  if root == nil then return nil end
  if root then vim.b.path_root = root end
  return root
end

tools.hl_str = function(hl, str) return "%#" .. hl .. "#" .. str .. "%*" end

local branch_cache = setmetatable({}, { __mode = "k" })
local remote_cache = setmetatable({}, { __mode = "k" })

local function git_cmd(root, ...)
  local job = vim.system({ "git", "-C", root, ... }, { text = true }):wait()

  if job.code ~= 0 then return nil, job.stderr end
  return vim.trim(job.stdout)
end


tools.get_git_remote_name = function(root)
  if not root then return nil end
  if remote_cache[root] then return remote_cache[root] end

  local out = git_cmd(root, "config", "--get", "remote.origin.url")
  if not out then return nil end

  -- normalise to short repo name
  out = out:gsub(":", "/"):gsub("%.git$", ""):match("([^/]+/[^/]+)$")

  remote_cache[root] = out
  return out
end

function tools.get_git_branch(root)
  if not root then return nil end
  if branch_cache[root] then return branch_cache[root] end

  local out = git_cmd(root, "rev-parse", "--abbrev-ref", "HEAD")
  if out == "HEAD" then
    local commit = git_cmd(root, "rev-parse", "--short", "HEAD")
    commit = tools.hl_str("Comment", "(" .. commit .. ")")
    out = string.format("%s %s", out, commit)
  end

  branch_cache[root] = out

  return out
end

tools.diagnostics_available = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local diagnostics = vim.lsp.protocol.Methods.textDocument_publishDiagnostics

  for _, cfg in pairs(clients) do
    if cfg:supports_method(diagnostics) then return true end
  end

  return false
end

tools.group_number = function(num, sep)
  if num < 999 then return tostring(num) end

  num = tostring(num)
  return num:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
end

tools.get_lsp_completion_context = function(completion)
  local ok, source_name = pcall(
    function() return vim.lsp.get_client_by_id(completion.client_id).name end
  )
  if not ok then return nil end

  if source_name == "ts_ls" then
    return completion.detail
  elseif source_name == "pyright" and completion.labelDetails ~= nil then
    return completion.labelDetails.description
  elseif source_name == "texlab" then
    return completion.detail
  elseif source_name == "clangd" then
    local doc = completion.documentation
    if doc == nil then return nil end

    local import_str = doc.value:gsub("[\n]+", "")

    local str = import_str:match("<(.-)>")
    if str then return "<" .. str .. ">" end

    str = import_str:match("[\"'](.-)[\"']")
    if str then return '"' .. str .. '"' end

    return nil
  end
end

tools.lens = function(render, pos_list, nearest, wkg_i, _)
  local hl = "Folded"
  local pattern = vim.fn.getreg("/")
  pattern = pattern:gsub("^\\<", ""):gsub("\\>$", "")

  local cur_ratio = "(" .. ("%d/%d"):format(wkg_i, #pos_list) .. ")"
  local chunks = {
    { "   ", "Ignore" },
    { [[ ⌕ "]], hl },
    { pattern, hl },
    { [[" ]], hl },
    { cur_ratio, hl },
    { " ", hl },
  }

  local lnum, col = pos_list[wkg_i][1], pos_list[wkg_i][2]
  render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
end

_G.tools.ui.kind_icons_spaced = icons_spaced
