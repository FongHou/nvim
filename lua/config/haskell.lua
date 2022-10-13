local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local utils = require("null-ls.utils")

local M = {}

M.ghcid = {
  name = "ghcid",
  method = methods.internal.DIAGNOSTICS_ON_SAVE,
  filetypes = { "haskell" },
  generator = h.generator_factory({
    command = "bash",
    args = {
      "-c",
      [[
        [ -f ghcid.log ] && sleep 1 && \
          cat ghcid.log | \
          grep -A1 -E '.*: (error|warning):' | \
          grep -v '\--' | \
          sed -E ':a; $!N; s/\n\s+/ /; ta; P; D'
      ]],
    },
    format = "line",
    multiple_files = true,
    on_output = function(line, _)
      local filename, row, end_row, col, end_col, severity, message =
        line:match("([^:]+):%(?(%d+)[)(-]?(%d*)%)?:%(?(%d+)[)(-]?(%d*)%)?:%s*(%w+):(.*)")

      return {
        filename = filename,
        row = row,
        -- end_row = end_row or row,
        col = col,
        end_col = end_col or col,
        severity = h.diagnostics.severities[severity],
        message = message,
      }
    end,
  }),
  cwd = h.cache.by_bufnr(function(params)
    return utils.root_pattern("ghcid.log")(params.bufname)
  end),
}

return M
