-- lua/colors/init.lua
-- 颜色方案管理模块

local M = {}

local function load_scheme(name)
  local ok, colors = pcall(require, "colors." .. name)
  if not ok then
    vim.notify("Colorscheme '" .. name .. "' not found!", vim.log.levels.ERROR)
    return nil
  end
  return colors
end

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

function M.set(name)
  local colors = load_scheme(name)
  if not colors then return end

  -- 设置背景模式
  if name == "solarized_light" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end

  vim.o.termguicolors = true
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.g.colors_name = name

  -- 通用高亮
  hl("Normal",      { fg = colors.fg, bg = colors.bg })
  hl("NormalNC",    { fg = colors.fg, bg = colors.bg })
  hl("NormalFloat", { bg = colors.sel, fg = colors.fg })

  hl("LineNr",        { fg = colors.line_nr or colors.comment, bg = colors.bg })
  hl("CursorLineNr",  { fg = colors.yellow, bg = colors.bg, bold = true })
  hl("SignColumn",    { bg = colors.bg })
  hl("StatusLine",    { fg = colors.fg, bg = colors.sel, bold = true })
  hl("StatusLineNC",  { fg = colors.comment, bg = colors.bg })
  hl("VertSplit",     { fg = colors.comment, bg = colors.bg })
  hl("Folded",        { fg = colors.comment, bg = colors.bg, italic = true })

  hl("Comment",     { fg = colors.comment, italic = true })
  hl("Constant",    { fg = colors.cyan })
  hl("String",      { fg = colors.green })
  hl("Identifier",  { fg = colors.purple })
  hl("Function",    { fg = colors.blue })
  hl("Statement",   { fg = colors.orange or colors.yellow, bold = true })
  hl("Keyword",     { fg = colors.pink })
  hl("Type",        { fg = colors.yellow })
  hl("PreProc",     { fg = colors.red })
  hl("Number",      { fg = colors.cyan })
  hl("Boolean",     { fg = colors.orange or colors.yellow, bold = true })
  hl("Special",     { fg = colors.pink })
  hl("Delimiter",   { fg = colors.fg })
  hl("Operator",    { fg = colors.purple, bold = true })

  hl("Search",      { fg = colors.bg, bg = colors.yellow, reverse = true })
  hl("IncSearch",   { fg = colors.bg, bg = colors.yellow, bold = true })

  hl("CursorLine",  { bg = colors.sel })
  hl("Visual",      { bg = colors.sel })

  hl("Error",       { fg = colors.red, bold = true })
  hl("WarningMsg",  { fg = colors.orange, bold = true })
  hl("Todo",        { fg = colors.yellow, italic = true })

  -- Treesitter
  hl("@function",   { fg = colors.blue })
  hl("@keyword",    { fg = colors.pink })
  hl("@type",       { fg = colors.yellow })
  hl("@string",     { fg = colors.green })
  hl("@constant",   { fg = colors.cyan })
  hl("@comment",    { fg = colors.comment, italic = true })

  -- LSP
  hl("LspDiagnosticsError",   { fg = colors.red })
  hl("LspDiagnosticsWarning", { fg = colors.orange })
  hl("LspDiagnosticsInfo",    { fg = colors.blue })
  hl("LspDiagnosticsHint",    { fg = colors.cyan })

  -- 终端颜色（可选）
  if name == "solarized" then
    vim.g.terminal_color_0  = "#002b36"
    vim.g.terminal_color_1  = "#dc322f"
    vim.g.terminal_color_2  = "#859900"
    vim.g.terminal_color_3  = "#b58900"
    vim.g.terminal_color_4  = "#268bd2"
    vim.g.terminal_color_5  = "#d33682"
    vim.g.terminal_color_6  = "#2aa198"
    vim.g.terminal_color_7  = "#839496"
    vim.g.terminal_color_8  = "#073642"
    vim.g.terminal_color_9  = "#cb4b16"
    vim.g.terminal_color_10 = "#586e75"
    vim.g.terminal_color_11 = "#657b83"
    vim.g.terminal_color_12 = "#839496"
    vim.g.terminal_color_13 = "#6c71c4"
    vim.g.terminal_color_14 = "#93a1a1"
    vim.g.terminal_color_15 = "#fdf6e3"
  end
end

return M
