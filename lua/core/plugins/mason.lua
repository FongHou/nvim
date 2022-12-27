local M = {
  "williamboman/mason.nvim",
  -- cmd = "Mason",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
}

function M.config()
  require("core.plugins.lsp.mason")
end

return M
