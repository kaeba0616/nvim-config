---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'json',
    'go',
    'sql',
    'dockerfile',
    'python',
    'bash',
    'c',
    'diff',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
  },
  auto_install = true,
  highlight = {
    enable = true,
    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --  If you are experiencing weird indenting issues, add the language to
    --  the list of additional_vim_regex_highlighting and disabled languages for indent.
    additional_vim_regex_highlighting = { 'ruby' },
  },
  indent = { enable = true, disable = { 'ruby' } },
  injections = {
    enable = true,
  },
}

local tsq = vim.treesitter.query

local bash_format = [[
(program
	(comment) @preceder (#eq? @preceder "# @lang %s")
	.
	(variable_assignment
	  (raw_string) @injection.content 
	  (#offset! @injection.content 0 1 0 -1)
	  (#set! injection.language "%s")
    )
  )
]]
local function set_injections(base_lang, format_string, target_langs)
  local combined_query = ''
  for _, lang in ipairs(target_langs) do
    combined_query = combined_query .. string.format(format_string, lang, lang)
  end
  tsq.set(base_lang, 'injections', combined_query)
end

local target_langs = {
  'json',
  'sql',
}
set_injections('bash', bash_format, target_langs)

-- set parser to env filetype
vim.treesitter.language.register('bash', 'env')
