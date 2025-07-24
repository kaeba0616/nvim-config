vim.filetype.add {
  pattern = {
    ['.?env.*'] = 'env', -- Matches .env, .env.local, env, env.example, etc.
  },
}
