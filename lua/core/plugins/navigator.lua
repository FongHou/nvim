local M = {
  "ThePrimeagen/harpoon",
  dependencies = {
    "preservim/tagbar",
  },
  config = function()
    local map = vim.keymap.set

    map("n", "<C-a>", require("harpoon.mark").add_file, { desc = "Harpoon add file" })
    map("n", "<C-n>", require("harpoon.ui").nav_next, { desc = "Harpoon next file" })
    map("n", "<C-p>", require("harpoon.ui").nav_prev, { desc = "Harpoon prev file" })
    map("n", "<C-t>", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon list file" })
    map("n", "g[", "<cmd>TagbarToggle<cr>", { desc = "Toggle tagbar" })
    map("n", "g]", "<cmd>Telescope tags<cr>", { desc = "Search tags" })
  end,
}

return M
