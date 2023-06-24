local M = {
  "ThePrimeagen/harpoon",
  dependencies = {
    "preservim/tagbar",
  },
  config = function()
    local map = vim.keymap.set

    map("n", "<C-a>", require("harpoon.mark").add_file, { desc = "Harpoon add" })
    map("n", "<C-n>", require("harpoon.ui").nav_next, { desc = "Harpoon next" })
    map("n", "<C-p>", require("harpoon.ui").nav_prev, { desc = "Harpoon prev" })
    map("n", "<leader>bh", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon list" })
    map("n", "g[", "<cmd>TagbarToggle<cr>", { desc = "Toggle tagbar" })
    map("n", "g]", "<cmd>Telescope tags<cr>", { desc = "Search tags" })
  end,
}

return M
