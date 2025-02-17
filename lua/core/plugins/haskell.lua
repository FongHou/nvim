local M = {
  "fonghou/fzf-hoogle.vim",
  dependencies = {
    "junegunn/fzf",
    "mrcjkb/haskell-snippets.nvim",
  },
  ft = "haskell",
}

function M.config()
  require("lspconfig").hls.setup({
    autostart = false,
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost", "TextChanged" }, {
        group = vim.api.nvim_create_augroup("hls-refresh-codelens", {}),
        callback = function()
          if client.server_capabilities.codeLensProvider then
            vim.lsp.codelens.refresh()
          end
        end,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("hls-stop-client", {}),
        callback = function()
          vim.lsp.stop_client(client, false)
        end,
        buffer = bufnr,
      })
    end,

    single_file_support = false,

    settings = {
      haskell = {
        cabalFormattingProvider = "cabalfmt",
        formattingProvider = "fourmolu",
        checkProject = false,
        plugin = {
          ["ghcide-completions"] = {
            config = {
              snippetsOn = false,
            },
          },
          importLens = {
            globalOn = false,
          },
          haddockComments = {
            globalOn = false,
          },
          hlint = {
            globalOn = false,
          },
          retrie = {
            globalOn = false,
          },
          splice = {
            globalOn = false,
          },
        },
      },
    },
  })

  local luasnip = require("luasnip")
  local hasksnip = require("haskell-snippets").all
  luasnip.add_snippets("haskell", hasksnip, { key = "haskell" })

  local autopairs = require("nvim-autopairs")
  autopairs.remove_rule("'")
  autopairs.remove_rule("`")
end

function M.ghcid()
  local helpers = require("null-ls.helpers")
  local methods = require("null-ls.methods")
  local utils = require("null-ls.utils")
  return {
    name = "ghcid",
    meta = { url = "https://github.com/ndmitchell/ghcid" },
    method = methods.internal.DIAGNOSTICS_ON_SAVE,
    filetypes = { "haskell" },
    generator = helpers.generator_factory({
      command = "bash",
      args = {
        "-c",
        [[ sleep 1 && [ -f ghcid.log ] && cat ghcid.log \
          | grep -A2 -E '.*: (error|warning):' \
          | grep -v '\--' \
          | paste -s -d'\0\t\n' - \
          | tr -s '\t' ' '
      ]],
      },
      format = "line",
      multiple_files = true,
      on_output = function(line, _)
        local filename, row, end_row, col, end_col, severity, message =
          line:match("([^:]+):%(?(%d+)[-,]?(%d*)%)?[:-]%(?(%d+)[-,]?(%d*)%)?:%s*(%w+):%s*(.*)")

        if end_col == nil or end_col == "" then
          end_col = col
        end

        if end_row == nil or end_row == "" then
          end_row = row
        else
          end_row, col = col, end_row
        end

        return {
          filename = filename,
          row = row,
          end_row = end_row,
          col = col,
          end_col = end_col + 1,
          severity = helpers.diagnostics.severities[severity],
          message = message,
        }
      end,
    }),
    cwd = helpers.cache.by_bufnr(function(params)
      return utils.root_pattern(".ghci*")(params.bufname)
    end),
  }
end

function M.hlint()
  local helpers = require("null-ls.helpers")
  local methods = require("null-ls.methods")
  return {
    name = "hlint",
    meta = { url = "https://github.com/ndmitchell/hlint" },
    method = methods.internal.DIAGNOSTICS_ON_SAVE,
    filetypes = { "haskell" },
    generator = helpers.generator_factory({
      command = "hlint",
      args = { "--json", "$FILENAME" },
      format = "json",
      check_exit_code = { 1 },
      ignore_stderr = true,
      on_output = function(params)
        local diagnostics = {}
        local severities = {
          Warning = 3,
          Suggestion = 4,
        }
        for _, o in ipairs(params.output) do
          table.insert(diagnostics, {
            row = o.startLine,
            end_row = o.endLine,
            col = o.startColumn,
            end_col = o.endColumn,
            message = o.hint,
            severity = severities[o.severity],
          })
        end
        return diagnostics
      end,
    }),
  }
end

vim.api.nvim_create_user_command("HlintApply", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  local c = vim.api.nvim_win_get_cursor(0)
  vim.cmd(
    string.format("silent !hlint %s --refactor --refactor-options='--inplace --pos %s,%s' ", bufname, c[1], c[2] + 1)
  )
end, { nargs = 0 })

vim.api.nvim_create_user_command("HlintApplyAll", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  vim.cmd(string.format("silent !hlint %s --refactor --refactor-options='--inplace' ", bufname))
end, { nargs = 0 })

return M
