local M = {
  "rcarriga/nvim-notify",
  dependencies = {
    "mbbill/undotree",
    "mg979/vim-visual-multi",
    "preservim/tagbar",
    "tpope/vim-repeat",
  },
}

function M.config()
  vim.notify = require("notify")
end

return M
