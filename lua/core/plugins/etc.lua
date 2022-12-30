local M = {
  "ThePrimeagen/harpoon",
  dependencies = {
    "mbbill/undotree",
    "mg979/vim-visual-multi",
    "preservim/tagbar",
    "rcarriga/nvim-notify",
    "tpope/vim-repeat",
  },
}

function M.config()
  vim.notify = require("notify")
end

return M
