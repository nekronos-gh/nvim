local bundle_imports = { { import = "bundles" } }
local bundle_manifest = vim.fn.stdpath "data" .. "/nix-bundles.lua"

if (vim.uv or vim.loop).fs_stat(bundle_manifest) then
  local bundles = dofile(bundle_manifest)
  assert(type(bundles) == "table", "Nix bundle manifest must return a list")

  vim.g.nix_managed_tools = true
  bundle_imports = { { import = "bundles.core" } }
  for _, bundle in ipairs(bundles) do
    assert(type(bundle) == "string", "Nix bundle names must be strings")
    table.insert(bundle_imports, { import = "bundles." .. bundle })
  end
end

require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^5", -- Remove version tracking to elect for nightly AstroNvim
    import = "astronvim.plugins",
    opts = { -- AstroNvim options must be set here with the `import` key
      mapleader = ",", -- This ensures the leader key must be configured before Lazy is set up
      maplocalleader = " ", -- This ensures the localleader key must be configured before Lazy is set up
      icons_enabled = true, -- Set to false to disable icons (if no Nerd Font is available)
      pin_plugins = false, -- Use lazy-lock.json instead of AstroNvim's version snapshot
      update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
    },
  },
  { import = "community" },
  { import = "plugins" },
  unpack(bundle_imports),
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  install = { colorscheme = { "astrotheme", "habamax" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])
