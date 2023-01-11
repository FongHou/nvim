local M = {
  "ahmedkhalf/project.nvim",
}

function M.config()
  require("project_nvim").setup({
    patterns = {
      ".git",
      "package.json",
      ".terraform",
      "go.mod",
      "requirements.yml",
      "pyrightconfig.json",
      "pyproject.toml",
      "deps.edn",
      "project.clj",
      "*.cabal",
      "stack.yaml",
    },
    -- detection_methods = { "lsp", "pattern" },
    detection_methods = { "pattern" },
  })
end

return M
