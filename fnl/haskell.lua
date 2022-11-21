-- cabal install ghcid hlint apply-refact
local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local utils = require("null-ls.utils")
local log = require("null-ls.logger")

local M = {}

M.ghcid = {
  name = "ghcid",
  meta = { url = "https://github.com/ndmitchell/ghcid" },
  method = methods.internal.DIAGNOSTICS_ON_SAVE,
  filetypes = { "haskell" },
  generator = h.generator_factory({
    command = "bash",
    args = {
      "-c",
      [[ sleep 2 && [ -f ghcid.log ] && cat ghcid.log \
          | grep -A1 -E '.*: (error|warning):' \
          | grep -v '\--' \
          | paste -sd'\0\n' -
      ]],
    },
    format = "line",
    multiple_files = true,
    on_output = function(line, _)
      local filename, row, end_row, col, end_col, severity, message =
        line:match("([^:]+):%(?(%d+)[)(-]?(%d*)%)?:%(?(%d+)[)(-]?(%d*)%)?:%s*(%w+):(.*)")

      if end_row == nil or end_row == "" then
        end_row = row
      end

      if end_col == nil or end_col == "" then
        end_col = col
      end

      return {
        filename = filename,
        row = row,
        end_row = end_row,
        col = col,
        end_col = end_col + 1,
        severity = h.diagnostics.severities[severity],
        message = message,
      }
    end,
  }),
  cwd = h.cache.by_bufnr(function(params)
    return utils.root_pattern("ghcid.log")(params.bufname)
  end),
}

M.hlint = {
  name = "hlint",
  meta = { url = "https://github.com/ndmitchell/hlint" },
  method = methods.internal.DIAGNOSTICS_ON_SAVE,
  filetypes = { "haskell" },
  generator = h.generator_factory({
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
