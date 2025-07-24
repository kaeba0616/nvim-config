local harpoon = require 'harpoon'
local wk = require 'which-key'

-- Harpoon setup
harpoon:setup {
  default = {
    display = function(item)
      return item.context.file_name or vim.fn.fnamemodify(item.value, ':t')
    end,
    select = function(item)
      if item and item.value then
        vim.cmd('edit ' .. vim.fn.fnameescape(item.value))
      else
        vim.notify('Invalid Harpoon item: ' .. vim.inspect(item), vim.log.levels.WARN)
      end
    end,
  },
}

-- Harpoon item creation
local function create_harpoon_item(path)
  if not path or path == '' then
    return nil
  end
  local clean_path = path:gsub('^oil://', '') -- Using Oil
  local is_dir = vim.fn.isdirectory(clean_path) == 1
  local clean_path_no_trail = clean_path:gsub('/$', '')
  local name = vim.fn.fnamemodify(clean_path_no_trail, ':t') .. (is_dir and '/' or '')
  return { value = clean_path, context = { file_name = name } }
end

-- Cache management
local cache = { items = nil }
local function update_cache()
  cache.items = harpoon:list().items
end
update_cache()

-- Autocmd for cache update
vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*harpoon*',
  callback = update_cache,
  desc = 'Update Harpoon cache when quick menu closes',
})

-- Mapping utilities
local mapping_opts = { mode = 'n', icon = { icon = '󰈮', color = 'azure' } }

local function get_desc(idx)
  local item = cache.items[idx]
  return item and item.context.file_name or ''
end

-- Mappings
local mappings = {
  {
    '<leader>ha',
    function()
      local item = create_harpoon_item(vim.fn.expand '%:p')
      if item then
        harpoon:list():add(item)
        update_cache()
      end
    end,
    desc = '[H]arpoon [A]dd file',
    mode = mapping_opts.mode,
    icon = mapping_opts.icon,
  },
  {
    '<leader>hl',
    function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = '[H]arpoon [L]ist',
    mode = mapping_opts.mode,
    icon = mapping_opts.icon,
  },
}

-- Dynamic mappings for <leader>1 to <leader>5 and <leader>h1 to <leader>h5
for _, idx in ipairs { 1, 2, 3, 4, 5, 6 } do
  table.insert(mappings, {
    string.format('<leader>%d', idx),
    function()
      harpoon:list():select(idx)
    end,
    desc = function()
      return get_desc(idx)
    end,
    mode = mapping_opts.mode,
    icon = mapping_opts.icon,
  })
  table.insert(mappings, {
    string.format('<leader>h%d', idx),
    function()
      local item = create_harpoon_item(vim.fn.expand '%:p')
      if item then
        harpoon:list():replace_at(idx, item)
        update_cache()
      end
    end,
    desc = string.format('[H]arpoon Save [%d]', idx),
    mode = mapping_opts.mode,
    icon = mapping_opts.icon,
  })
end

-- Register mappings
wk.add(mappings)
