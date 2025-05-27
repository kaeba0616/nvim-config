return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    -- allowed_dirs = { '~/workspace/' },
    suppressed_dirs = { '~/', '~/workspace/', '~/Downloads', '/' },
    -- log_level = 'debug',
  },
}
