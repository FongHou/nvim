local M = {
  "junegunn/fzf",
  dependencies = {
    "fonghou/fzf-hoogle.vim",
    "fonghou/tmuxjump.vim",
  },
  ft = "haskell",
}

function M.config()
  local autopairs = require("nvim-autopairs")
  autopairs.remove_rule("'")
  autopairs.remove_rule("`")
end

return M
