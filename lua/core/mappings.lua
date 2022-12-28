local map = vim.keymap.set
local default_options = { silent = true }
local expr_options = { expr = true, silent = true }

--Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

-- better indenting
map("v", "<", "<gv", default_options)
map("v", ">", ">gv", default_options)

-- paste over currently selected text without yanking it
map("v", "p", '"_dp', default_options)
map("v", "P", '"_dP', default_options)

-- Tab switch buffer
map("n", "<tab>", require("harpoon.ui").nav_next, default_options)
map("n", "<S-tab>", require("harpoon.ui").nav_prev, default_options)

-- Cancel search highlighting with ESC
map("n", "<esc>", ":nohlsearch<Bar>:echo<CR>", default_options)

-- Autocorrect spelling from previous error
map("i", "<c-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u", default_options)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", default_options)
map("x", "J", ":move '>+1<CR>gv-gv", default_options)

-- move over a closing element in insert mode
map("i", "<C-l>", function()
  return require("core.utils.functions").escapePair()
end, default_options)

local wk = require("which-key")

-- register non leader based mappings
wk.register({
  sa = "Add surrounding",
  sd = "Delete surrounding",
  sh = "Highlight surrounding",
  sn = "Surround update n lines",
  sr = "Replace surrounding",
  sF = "Find left surrounding",
  sf = "Replace right surrounding",
})

-- Register leader based mappings
wk.register({
  ["<tab>"] = {
    require("harpoon.ui").toggle_quick_menu,
    "List Harpoon buffers",
  },
  b = {
    name = "Buffers",
    a = {
      require("harpoon.mark").add_file,
      "Add Harpoon buffer",
    },
    b = {
      "<cmd>Telescope buffers<cr>",
      "Find buffer",
    },
    D = {
      "<cmd>%bd|e#|bd#<cr>",
      "Close all but the current buffer",
    },
    d = { "<cmd>Bdelete<cr>", "Close buffer" },
  },
  f = {
    name = "Files",
    b = { "<cmd>Telescope file_browser grouped=true<cr>", "File browser" },
    f = { "<cmd>" .. require("core.utils.functions").telescope_find_files() .. "<cr>", "Find File" },
    p = { "<cmd>Neotree reveal toggle<cr>", "Toggle Filetree" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    s = { "<cmd>w<cr>", "Save Buffer" },
    z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
  },
  m = {
    name = "Misc",
    c = { "<cmd>lua require('core.utils.functions').toggle_colorcolumn()<cr>", "Toggle Colorcolumn" },
    C = { "<cmd>:CBcatalog<cr>", "Commentbox Catalog" },
    d = { "<cmd>lua require('core.plugins.lsp.utils').toggle_diagnostics()<cr>", "Toggle Diagnostics" },
    l = { "<cmd>source ~/.config/nvim/snippets/*<cr>", "Reload snippets" },
    o = { "Options" },
    p = { "<cmd>Lazy check<cr>", "Lazy check" },
    s = { "<cmd>SymbolsOutline<cr>", "Toggle SymbolsOutline" },
  },
  q = {
    name = "Quickfix",
    j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
    k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    q = { "<cmd>lua vim.diagnostic.setqflist()<cr>", "Quickfix Diagnostics" },
    t = { "<cmd>TodoQuickFix<cr>", "Show TODOs" },
  },
  -- hydra heads
  s = { "Search" },
  w = { "Windows" },
  z = { "Spelling" },
}, { prefix = "<leader>", mode = "n", default_options })
