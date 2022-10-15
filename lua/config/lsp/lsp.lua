local nvim_lsp = require("lspconfig")
local utils = require("config.lsp.utils")
local opts = require("config.lsp.opts")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autoclompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
-- enable folding capabilities for nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local servers = {
  "bashls",
  "clojure_lsp",
  "denols",
  "dockerls",
  "jsonls",
  "pyright",
  "sumneko_lua",
  "terraformls",
  "texlab",
  "tsserver",
  "yamlls",
}

local function root_pattern(lsp)
  if lsp == "denols" then
    return nvim_lsp.util.root_pattern({ "deno.json", "deno.jsonc" })
  end
  if lsp == "tsserver" then
    return nvim_lsp.util.root_pattern("tsconfig.json")
  end
end

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = function(client, bufnr)
      utils.custom_lsp_attach(client, bufnr)
    end,
    before_init = function(_, config)
      if lsp == "pyright" then
        config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
      end
    end,
    root_dir = root_pattern(lsp),
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {
      json = opts.json,
      Lua = opts.lua,
      redhat = { telemetry = { enabled = false } },
      texlab = opts.tex,
      yaml = opts.yaml,
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
