-- ~/.config/nvim/plugin/0-tangerine.lua

-- pick your plugin manager, default [standalone]
local pack = "packer"

local function bootstrap(url)
  local name = url:gsub(".*/", "")
  local path = vim.fn.stdpath([[data]]) .. "/site/pack/" .. pack .. "/start/" .. name

  if vim.fn.isdirectory(path) == 0 then
    print(name .. ": installing in data dir...")

    vim.fn.system({ "git", "clone", "--depth", "1", url, path })

    vim.cmd([[redraw]])
    print(name .. ": finished installing")
  end
end

bootstrap("https://github.com/udayvir-singh/tangerine.nvim")

require("tangerine").setup({
  target = vim.fn.stdpath([[data]]) .. "/tangerine",

  -- compile files in &rtp
  rtpdirs = {
    "plugin",
    "colors",
  },

  compiler = {
    -- disable popup showing compiled files
    verbose = false,

    -- compile every time changed are made to fennel files or on entering vim
    hooks = { "oninit" },
  },
})
