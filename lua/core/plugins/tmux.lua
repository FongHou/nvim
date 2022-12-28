local M = {
  "mtikekar/nvim-send-to-term",
  dependencies = {
    "christoomey/vim-tmux-navigator",
  },
}

function M.init()
  vim.g.send_disable_mapping = true
  vim.g.send_multiline = {
    ghci = {
      begin = ":{\n",
      ["end"] = "\n:}\n",
      newline = "\n",
    },
  }

  vim.g.tmux_navigator_no_wrap = true
  vim.g.tmux_navigator_disable_when_zoomed = true
  vim.g.tmux_navigator_preserve_zoom = true
end

return M
