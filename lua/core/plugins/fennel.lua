return {
  "aileot/nvim-laurel",
  dependencies = {
    "udayvir-singh/tangerine.nvim",
  },
  config = function()
    require("lspconfig").fennel_ls.setup({})
  end,
}
