-- lua/colors/solarized_light.lua

return {
  -- === 背景与前景（浅色模式）===
  bg        = "#fdf6e3",   -- base3: 主背景（light）
  sel       = "#eee8d5",   -- base2: 选中行背景
  fg        = "#657b83",   -- base00: 主文本（深灰蓝）
  fg_alt    = "#586e75",   -- base01: 强文本
  comment   = "#839496",   -- base0: 浅色模式下用 base0 作注释（不要太暗）
  line_nr   = "#93a1a1",   -- base1: 行号颜色

  -- === 语法高亮（保持与 dark 一致）===
  red       = "#dc322f",
  green     = "#859900",
  yellow    = "#b58900",
  orange    = "#cb4b16",
  blue      = "#268bd2",
  pink      = "#d33682",
  purple    = "#6c71c4",
  cyan      = "#2aa198",
}
