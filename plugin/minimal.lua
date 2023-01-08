local function bootstrap(url)
  -- To manage the version of repo, the path should be where your plugin manager will download it.
  local name = url:gsub("^.*/", "")
  local path = vim.fn.stdpath("data") .. "/lazy/" .. name
  if not vim.loop.fs_stat(path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "--depth=1",
      url,
      path,
    })
  end
  vim.opt.runtimepath:prepend(path)
end

bootstrap("https://github.com/aileot/nvim-laurel")
bootstrap("https://github.com/ggandor/leap.nvim")
bootstrap("https://github.com/ggandor/leap-ast.nvim")
bootstrap("https://github.com/nvim-treesitter/nvim-treesitter")
bootstrap("https://github.com/udayvir-singh/tangerine.nvim")

require("tangerine").setup({
  target = vim.fn.stdpath("data") .. "/tangerine",

  -- compile files in &rtp
  rtpdirs = {
    "plugin",
    "colors",
  },

  compiler = {
    -- disable popup showing compiled files
    verbose = false,

    -- compile every time changed are made to fennel files or on entering vim
    hooks = { "onsave", "oninit" },
  },
})
