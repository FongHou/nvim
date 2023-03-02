local M = {
  "simrat39/rust-tools.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
  ft = "rust",
  opts = {
    server = {
      on_attach = function(client, bufnr)
        local utils = require("core.plugins.lsp.utils")
        utils.custom_lsp_attach(client, bufnr)

        local rt = require("rust-tools")
        vim.keymap.set("n", "<Leader>lk", rt.hover_actions.hover_actions, { buffer = bufnr })
        vim.keymap.set("n", "<Leader>la", rt.code_action_group.code_action_group, { buffer = bufnr })
      end,
      standalone = false,
    },
  },
}

return M
