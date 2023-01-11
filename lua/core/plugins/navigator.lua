local M = {
  "alexghergh/nvim-tmux-navigation",
  dependencies = {
    "ThePrimeagen/harpoon",
  },
  config = function()
    require("nvim-tmux-navigation").setup({
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
      },
    })

    local map = vim.keymap.set
    local default_options = { silent = true }

    map("n", "<tab>", require("harpoon.ui").nav_next, default_options)
    map("n", "<S-tab>", require("harpoon.ui").nav_prev, default_options)

    require("which-key").register({
      ["<tab>"] = {
        require("harpoon.ui").toggle_quick_menu,
        "List marked buffers",
      },
      b = {
        name = "Buffers",
        m = {
          require("harpoon.mark").add_file,
          "Mark buffer",
        },
      },
    }, { prefix = "<leader>", mode = "n", default_options })
  end,
}

return M
