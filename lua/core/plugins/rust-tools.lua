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
      on_attach = function(client, buffer)
        local rt = require("rust-tools")
        vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = buffer, desc = "Hover" })
        vim.keymap.set("n", "<Leader>lk", rt.hover_actions.hover_actions, { buffer = buffer, desc = "Hover" })
        vim.keymap.set(
          "n",
          "<Leader>la",
          rt.code_action_group.code_action_group,
          { buffer = buffer, desc = "Code Action" }
        )
      end,
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
            extraArgs = { "--all", "--", "-W", "clippy::all" },
          },
        },
      },
      standalone = false,
    },
  },
}

return M
