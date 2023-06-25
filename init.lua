-- vscode uses .init.fnl
if vim.g.vscode then
  return
end

vim.g.python3_host_prog = "/usr/bin/python3"

-- References to ./lua/

-- Chech prerequisites
-- require("core.checks")
-- Load global functions
require("core.globals")
-- Plugin management via lazy
require("core.lazy")
-- "Global" Keymappings
require("core.mappings")
-- All non plugin related (vim) options
require("core.options")
-- Vim autocommands/autogroups
require("core.autocmd")
