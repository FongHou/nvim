local settings = require("core.settings")
local nvim_lsp = require("lspconfig")
local utils = require("core.plugins.lsp.utils")
local lsp_settings = require("core.plugins.lsp.settings")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autoclompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.offsetEncoding = { "utf-16" }

require("core.utils.functions").on_attach(function(client, buffer)
  -- disable formatting for LSP clients as this is handled by null-ls
  -- TODO: not required anymore?
  -- client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = true
  vim.api.nvim_buf_set_option(buffer, "formatexpr", "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})")

  local bufopts = { noremap = true, silent = true, buffer = buffer }
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", bufopts)
  vim.keymap.set("n", "R", "<cmd>lua vim.lsp.codelens.run()<cr>", bufopts)
  vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", bufopts)
  vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", bufopts)
  require("core.plugins.lsp.keys").on_attach(client, buffer)
end)

for _, lsp in ipairs(settings.lsp_servers) do
  nvim_lsp[lsp].setup({
    before_init = function(_, config)
      if lsp == "pyright" then
        config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
      end
    end,
    on_attach = function(client, _)
      if lsp == "ruff_lsp" then
        client.server_capabilities.hover = false
      end
    end,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {
      json = lsp_settings.json,
      Lua = lsp_settings.lua,
      ltex = lsp_settings.ltex,
      redhat = { telemetry = { enabled = false } },
      texlab = lsp_settings.tex,
      yaml = lsp_settings.yaml,
    },
  })
end

local function define_signs(prefix)
  local error = prefix .. "SignError"
  local warn = prefix .. "SignWarn"
  local info = prefix .. "SignInfo"
  local hint = prefix .. "SignHint"
  vim.fn.sign_define(error, { text = "x", texthl = error })
  vim.fn.sign_define(warn, { text = "!", texthl = warn })
  vim.fn.sign_define(info, { text = "i", texthl = info })
  vim.fn.sign_define(hint, { text = "?", texthl = hint })
end

define_signs("Diagnostic")
define_signs("LspDiagnostics")
