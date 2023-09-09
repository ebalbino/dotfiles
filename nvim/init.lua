
-- Load lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "neovim/nvim-lspconfig" },
    { 'echasnovski/mini.nvim', version = '*' },
    { "zbirenbaum/copilot.lua" },
    {
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { 
                    "c", "lua", "bash", "javascript", 
                    "html", "dockerfile", "glsl", "json", 
                    "make", "ruby", "rust", "sql", 
                    "typescript", "vue", "yaml" 
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
            "ibhagwan/fzf-lua",
        },
        config = true
    },
    {
        "folke/zen-mode.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    { "hrsh7th/cmp-path"},
    { "hrsh7th/cmp-buffer"},
    { "hrsh7th/cmp-nvim-lsp"},
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    { 'hrsh7th/nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip' },
}

require("lazy").setup(plugins)

local set = vim.opt

set.hidden = true
set.swapfile = false
set.backup = false
set.hlsearch = false
set.wrap = false
set.mouse = 'a'
set.termguicolors = true
set.scrolloff = 2
set.number = true

set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

vim.cmd([[
  syntax enable
  colorscheme default
]])

-- =============================================================================
-- = Options =
-- =============================================================================
-- Completion options
set.completeopt = 'menuone,noinsert,noselect'
set.updatetime = 100

-- Search options
set.ignorecase = true
set.smartcase = true
set.wrapscan = true

-- Indent options
set.tabstop = 4
set.shiftwidth = 0
set.softtabstop = 4
set.expandtab = true
set.smartindent = true

-- Line options
set.showmatch = true
set.showbreak = '+++'
set.textwidth = 120
set.scrolloff = 5
vim.wo.linebreak = true

-- Move swapfiles and backupfiles to ~/.cache
set.directory = os.getenv('HOME') .. '/.cache/nvim'
set.backup = true
set.backupdir = os.getenv('HOME') .. '/.cache/nvim'

-- Enable undo features, even after closing vim
set.undofile = true
set.undodir = os.getenv('HOME') .. '/.cache/nvim'
set.undolevels = 10000

-- Lazy redraw
set.lazyredraw = true

-- Buffers/Tabs/Windows
set.hidden = true

-- Set spelling
set.spell = false

-- For git
vim.wo.signcolumn = 'yes'

-- Mouse support
set.mouse = 'a'

-- backspace behaviour
set.backspace = 'indent,eol,start'

-- Status line
set.showmode = false

-- Better display
set.cmdheight = 2

-- ========================================================================== --
-- ==                             KEY MAPPINGS                             == --
-- ========================================================================== --

-- Space as leader key
vim.g.mapleader = ' '

local bind = vim.keymap.set
local remap = {remap = true}

-- Enter command mode
bind('n', '<CR>', ':')

-- Escape to normal mode
bind('', '<C-L>', '<Esc>')
bind('i', '<C-L>', '<Esc>')
bind('t', '<C-L>', '<C-\\><C-n>')

-- Shortcuts
bind('', '<Leader>h', '^') 
bind('', '<Leader>l', 'g_')
bind('', '<C-u>', '<C-u>M')
bind('', '<C-d>', '<C-d>M')
bind('n', '<Leader>e', '%', remap)
bind('v', '<Leader>e', '%', remap)
bind('n', '<Leader>a', 'ggVG')

-- Basic clipboard interaction
if vim.fn.has('clipboard') == 1 then
  bind('', 'cp', '"+y')
  bind('', 'cv', '"+p')
end

-- Moving lines and preserving indentation
bind('n', '<C-k>', ':move .-2<CR>==')
bind('n', '<C-j>', ':move .+1<CR>==')
bind('v', '<C-j>', ":move '>+1<CR>gv=gv")
bind('v', '<C-k>', ":move '<-2<CR>gv=gv")

-- Commands
bind('n', '<Leader>w', ':write<CR>')
bind('n', '<Leader>qq', ':quitall<CR>')
bind('n', '<Leader>Q', ':quitall!<CR>')
bind('n', '<Leader>bq', ':bdelete<CR>')
bind('n', '<Leader>bl', ':buffer #<CR>')
bind('n', '<Leader>bb', ':buffers<CR>:buffer<Space>')
bind('n', '<Leader>dd', ':Lexplore %:p:h<CR>')
bind('n', '<Leader>da', ':Lexplore<CR>')

local builtin = require('telescope.builtin')
bind('n', '<leader>ff', builtin.find_files, {})
bind('n', '<leader>fg', builtin.live_grep, {})
bind('n', '<leader>fb', builtin.buffers, {})
bind('n', '<leader>fh', builtin.help_tags, {})

-- =============================================================================
-- = Commands =
-- =============================================================================
vim.cmd 'command! Config edit $MYVIMRC'
vim.cmd 'command! ConfigReload luafile $MYVIMRC'

-- Don't make mistakes, there are no such thing :)
vim.cmd 'command! -nargs=* W w'
vim.cmd 'command! -nargs=* Wq wq'
vim.cmd 'command! -nargs=* WQ wq'
vim.cmd 'command! -nargs=* Q q'
vim.cmd 'command! -nargs=* Qa qa'
vim.cmd 'command! -nargs=* QA qa'

require('copilot').setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
    ruby = true,
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {},
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})


---
-- Diagnostics
---

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

---
-- LSP config
---

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

_timers = {}
local function setup_diagnostics(client, buffer)
  if require("vim.lsp.diagnostic")._enable then
    return
  end

  local diagnostic_handler = function()
    local params = vim.lsp.util.make_text_document_params(buffer)
    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      if err then
        local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
        vim.lsp.log.error(err_msg)
      end
      if not result then
        return
      end
      vim.lsp.diagnostic.on_publish_diagnostics(
        nil,
        vim.tbl_extend("keep", params, { diagnostics = result.items }),
        { client_id = client.id }
      )
    end)
  end

  diagnostic_handler() -- to request diagnostics on buffer when first attaching

  vim.api.nvim_buf_attach(buffer, false, {
    on_lines = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
      _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
    end,
    on_detach = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
    end,
  })
end

---
-- LSP servers
---

lspconfig.tsserver.setup({})
lspconfig.html.setup({})
-- lspconfig.cssls.setup({})
lspconfig.eslint.setup({})
lspconfig.lua_ls.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.emmet_language_server.setup({})
lspconfig.sqlls.setup({})
lspconfig.volar.setup({})
lspconfig.bashls.setup({})
lspconfig.solargraph.setup({})


---
-- Autocomplete
---
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 1},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})

require("luasnip.loaders.from_vscode").lazy_load()

require('mini.base16').setup({
    palette = {
      base00 = '#112641',
      base01 = '#3a475e',
      base02 = '#606b81',
      base03 = '#8691a7',
      base04 = '#d5dc81',
      base05 = '#e2e98f',
      base06 = '#eff69c',
      base07 = '#fcffaa',
      base08 = '#ffcfa0',
      base09 = '#cc7e46',
      base0A = '#46a436',
      base0B = '#9ff895',
      base0C = '#ca6ecf',
      base0D = '#42f7ff',
      base0E = '#ffc4ff',
      base0F = '#00a5c5',
    },
    use_cterm = true,
    plugins = {
      default = false,
      ['echasnovski/mini.nvim'] = true,
    },
})
require('mini.comment').setup()
require('mini.cursorword').setup()
require('mini.map').setup()
require('mini.pairs').setup()
require('mini.starter').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()
