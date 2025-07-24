return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.omni_sql_no_default_maps = 1
      vim.g.db_ui_execute_on_save = 0
      vim.keymap.set({ 'n', 'v' }, '<leader>de', '<Plug>(DBUI_ExecuteQuery)', { noremap = true, desc = '[D]BUI [E]xecute SQL query' })
      vim.keymap.set({ 'n', 'v' }, '<leader>s', '<Nop>', { noremap = true })
      vim.keymap.set('n', '<leader>da', '<cmd>DBUIFindBuffer<cr>', { noremap = true, desc = '[D]BUI [A]dd SQL buffer' })
      vim.keymap.set('n', '<leader>dc', '<cmd>DBCompletionClearCache<cr>', { noremap = true, desc = '[D]BUI [C]lear cache' })
    end,
  },
}
