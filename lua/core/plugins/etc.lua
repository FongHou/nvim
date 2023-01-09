local M = {
  "rcarriga/nvim-notify",
  dependencies = {
    "mbbill/undotree",
    "tpope/vim-repeat",
  },
}

function M.config()
  vim.notify = require("notify")
end

return M
