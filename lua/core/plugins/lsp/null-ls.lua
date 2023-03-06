local nls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nls.setup({
  sources = {
    nls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
    -- nls.builtins.diagnostics.eslint_d,
    -- nls.builtins.formatting.prettier.with({
    --   extra_args = { "--single-quote", "false" },
    -- }),
    nls.builtins.formatting.deno_fmt,
    nls.builtins.formatting.terraform_fmt,
    nls.builtins.formatting.black,
    nls.builtins.formatting.goimports,
    nls.builtins.formatting.gofumpt,
    nls.builtins.formatting.rustfmt,
    nls.builtins.code_actions.shellcheck,
    nls.builtins.code_actions.gitsigns,
    nls.builtins.formatting.shfmt,
    nls.builtins.formatting.cabal_fmt,
    nls.builtins.formatting.fourmolu,
    require("core.plugins.haskell").ghcid(),
    require("core.plugins.haskell").hlint(),
  },
  on_attach = function(client, bufnr)
    vim.keymap.set(
      "n",
      "<leader>tF",
      "<cmd>lua require('core.plugins.lsp.utils').toggle_autoformat()<cr>",
      { desc = "Toggle format on save" }
    )
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          if AUTOFORMAT_ACTIVE then -- global var defined in functions.lua
            vim.lsp.buf.format({ bufnr = bufnr })
          end
        end,
      })
    end
  end,
})
