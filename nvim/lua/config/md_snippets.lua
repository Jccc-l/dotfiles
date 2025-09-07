-- 定义一个函数，在 Markdown 文件类型加载时执行
local function setup_markdown_keymaps()
  local bufnr = vim.api.nvim_get_current_buf()

  -- 辅助函数：设置 inoremap <buffer>
  local function inoremap(lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, 'i', lhs, rhs, { noremap = true, silent = true })
  end

  -- 设置 leader w 映射：复制当前单词并插入 [word]() 链接格式
  -- 注意：这个映射是在 FileType 触发后执行的，所以用 <buffer>
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>w', 'yiWi[<esc>Ea](<esc>pa', { noremap = true, silent = true })

  -- 插入模式下的快捷键
  inoremap(',f', '<Esc>/<++><CR>:nohlsearch<CR>"_c4l')
  inoremap('<c-e>', '<Esc>/<++><CR>:nohlsearch<CR>"_c4l')
  inoremap(',w', '<Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>')
  inoremap(',n', '---<Enter><Enter>')
  inoremap(',b', '**** <++><Esc>F*hi')
  inoremap(',s', '~~~~ <++><Esc>F~hi')
  inoremap(',i', '** <++><Esc>F*i')
  inoremap(',d', '`` <++><Esc>F`i')
  inoremap(',c', '```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA')
  inoremap(',m', '- [ ] ')
  inoremap(',p', '![](<++>) <++><Esc>F[a')
  inoremap(',a', '[](<++>) <++><Esc>F[a')  -- 和 ,p 一样，可能是别名
  inoremap(',1', '# <Enter><++><Esc>kA')
  inoremap(',2', '## <Enter><++><Esc>kA')
  inoremap(',3', '### <Enter><++><Esc>kA')
  inoremap(',4', '#### <Enter><++><Esc>kA')
  inoremap(',l', '--------<Enter>')
end

-- 使用 autocmd 在 FileType 为 markdown 时调用上面的函数
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    setup_markdown_keymaps()
  end,
})
