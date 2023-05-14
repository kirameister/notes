
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Following for file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--{{{Papckage on Lazy
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

require('lazy').setup({
  {
    -- ChatGPT
    -- 'jackMort/ChatGPT.nvim',
    {
      "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
          require("chatgpt").setup()
        end,
        dependencies = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        },
        popup_input = {
          submit = "<C-s>"
        }
    },

    { -- TabLine
      'crispgm/nvim-tabline',
      opts = {
        show_index = true,        -- show tab index
        show_modify = true,       -- show buffer modification indicator
        show_icon = false,        -- show file extension icon
        modify_indicator = '!',   -- modify indicator
        no_name = '無',         -- no name buffer name
        brackets = { '[', ']' },  -- file name brackets surrounding
        inactive_tab_max_length = 10,
      }
    },

    -- color schemes
    'rebelot/kanagawa.nvim',
    'folke/tokyonight.nvim',

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    { -- Set lualine as statusline
      'nvim-lualine/lualine.nvim',
      -- See `:help lualine.txt`
      opts = {
        options = {
          icons_enabled = false,
          theme = 'onedark',
          component_separators = '|',
          section_separators = '',
          fmt = string.lower,
        },
        sections = {
          lualine_a = {
            { 'mode', fmt = function(str) return str:sub(1,1) end }
          },
          lualine_b = {'branch'}
        },
      },
    },

    { -- Adds git releated signs to the gutter, as well as utilities for managing changes
      'lewis6991/gitsigns.nvim',
        opts = {
          -- See `:help gitsigns.txt`
          signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
          },
       },
    },

    { -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      -- See `:help indent_blankline.txt`
      opts = {
        -- those options are for 
        show_current_context = true,
        show_current_context_start = true,
        space_char_blankline = " ",
        show_trailing_blankline_indent = false,
      },
    },

    { -- Adds git releated signs to the gutter, as well as utilities for managing changes
      'lewis6991/gitsigns.nvim',
      opts = {
        -- See `:help gitsigns.txt`
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      },
    },

    -- file explorer
    --'nvim-tree/nvim-tree.lua',
    'lambdalisue/fern.vim',
    'lambdalisue/fern-hijack.vim',

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    { -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
      },
    },

    --{ -- Autocompletion
    --  'hrsh7th/nvim-cmp',
    --  dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    --},
    --'hrsh7th/cmp-path',
    --'hrsh7th/cmp-buffer',
    --'hrsh7th/cmp-cmdline',

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {} },

    -- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
      return vim.fn.executable 'make' == 1
      end,
    },

    { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
      end,
    },

  }
}, {})


--}}}


--{{{Configs from kickstart.nvim
-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true
-- Enable mouse mode
vim.o.mouse = ''

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true
vim.opt.listchars:append "space:⋅"

-- Save undo history
vim.o.undofile = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
    end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })


-- file explorer
--require("nvim-tree").setup()


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  --nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  --nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation') -- This is not relevant to Python
  --nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition') -- same as 'gd'
  --nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  --nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')

end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  pyright = {},
  --ruff_lsp = {},
  --sqls = {},
  --rls = {},
  clangd = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}



-- nvim-cmp setup
--local cmp = require 'cmp'
--local luasnip = require 'luasnip'

--luasnip.config.setup {}

--[[
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    --['<C-d>'] = cmp.mapping.scroll_docs(-4),
    --['<C-f>'] = cmp.mapping.scroll_docs(4),
    --['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
]]

--}}}


--{{{TabLine
vim.keymap.set('n', 'tc', ':tablast <Bar> tabnew<CR>', {silent = true})
vim.keymap.set('n', 'tx', ':tabclose<CR>', {silent = true})
vim.keymap.set('n', 'tn', ':tabnext<CR>', {silent = true})
vim.keymap.set('n', 'tp', ':tabprevious<CR>', {silent = true})
--}}}


--{{{colorscheme
--vim.cmd("colorscheme kanagawa-wave")
vim.cmd("colorscheme koehler")
--vim.cmd("colorscheme tokyonight-night")
--vim.cmd("colorscheme PaperColor")
--}}}


--{{{ Editing Settings..
vim.tabpagemax = 20       -- Max number of opened tab pages.
vim.shiftround = true     -- round it by shiftwidth when indenting with '<' or '>'
vim.infercase = true      -- case-insensitive in auto-completion.
vim.hidden = true         -- Hide buffer instead of close, to retain Undo history.
vim.switchbuf = useopen   -- Open already-opened buffer, instead of open it anew.
--{{{ Disalbe both Swap and Backup files.
vim.o.writebackup = true
vim.o.backup = false
vim.o.swapfile = false
--}}}

--{{{ Jump to matching pair by Tab
vim.keymap.set('n', '<Tab>', "%")
vim.keymap.set('v', '<Tab>', "%")
--}}}
-- Add '<' and '>' to matching pair.
vim.matchpairs = "(:),{:},[:],<:>"

--{{{ Move naturally by j and k even within wrapped lines.
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
--}}}

--{{{ 'v' twice to select until EOL
vim.keymap.set('v', 'v', '$h')
--}}}

--{{{ Tab-no-Tab/Indent settings
-- I prefer using the tabs..
vim.autoindent = true
-- If you like using tab..
vim.expandtab   = true
vim.tabstop     = 4
vim.shiftwidth  = 4
--}}}

--{{{ Disable screen bell.
vim.belloff     = 'all'
vim.visualbell  = false
--}}}

-- Let the backspace delete everything.
vim.backspace = indent,eol,start

-- Type 'jj' during the Input mode to enter normal mode.
vim.keymap.set('i', 'jj', '<Esc>')

--{{{ Emacs-like key-bindings during the Input mode.
vim.keymap.set('i', '<C-b>', '<Left>')
vim.keymap.set('i', '<C-f>', '<Right>')

vim.keymap.set('i', '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')
--}}}

--{{{ Move along Windows by Ctrl + hjkl
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<BS>', '<C-w>h') -- due to some funny shell config
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
--}}}

--{{{Use colon instead of semi-colon in normal mode
vim.keymap.set('n', ';', ':')
--}}}

--}}}


--{{{ Toggle various settings bt T + ?
vim.keymap.set('n', 'T', '<Nop>', {noremap = false})
vim.keymap.set('n', '[toggle]', '<Nop>')

vim.keymap.set('n', 'Ts', [[:setlocal spell!<CR>:setlocal spell?<CR>]])
vim.keymap.set('n', 'Tl', [[:setlocal list!<CR>:setlocal list?<CR>]])
vim.keymap.set('n', 'Tn', [[:setlocal number!<CR>:setlocal number?<CR>:setlocal relativenumber!<CR>:setlocal relativenumber?<CR>]])
vim.keymap.set('n', 'Tt', [[:setlocal expandtab!<CR>:setlocal expandtab?<CR>]])
vim.keymap.set('n', 'Tw', [[:setlocal wrap!<CR>:setlocal wrap?<CR>]])
--}}}
--{{{Mappings for Pane (using the same prefix key)..
vim.keymap.set('n', 'tw', '<C-w>w')
--horisontal split
vim.keymap.set('n', 'tt', ':<C-u>vs<CR>')
--vertical split
vim.keymap.set('n', 'tr', ':<C-u>sp<CR>')
-- Switch (split) Window
vim.keymap.set('n', '<S-Left>',  '<C-w>h')
vim.keymap.set('n', '<S-Right>', '<C-w>l')
vim.keymap.set('n', '<S-Up>',    '<C-w>k')
vim.keymap.set('n', '<S-Down>',  '<C-w>j')
-- Move along Windows by Ctrl + hjkl
--vim.keymap.set('n', '<C-h>',  '<Nop>')
--vim.keymap.set('n', '<C-h>',  '<C-w>h', {noremap = true, silent = true})
--vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})

vim.keymap.set('n', '<C-j>',  '<C-w>j')
vim.keymap.set('n', '<C-k>',  '<C-w>k')
vim.keymap.set('n', '<C-l>',  '<C-w>l')
-- Change (split) Window size by Ctrl + Shift + arrow
vim.keymap.set('n', '<S-C-Left>',  '<C-w><<CR>')
vim.keymap.set('n', '<S-C-Right>', '<C-w>><CR>')
vim.keymap.set('n', '<S-C-Up>',    '<C-w>-<CR>')
vim.keymap.set('n', '<S-C-Down>',  '<C-w>+<CR>')
--}}}


--{{{ Search Settings..
vim.o.ignorecase  = true
vim.o.smartcase  = true
vim.o.incsearch  = true
vim.o.hlsearch  = true

-- Type ESC twice to remove search highlights.
vim.keymap.set('n', '<ESC><ESC>', ':nohlsearch<CR>')

-- Let the matched word be on middle of the screen after jump.
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')
vim.keymap.set('n', 'g*', 'g*zz')
vim.keymap.set('n', 'g#', 'g#zz')

-- You can also include '/' or '?' in search term as is.
vim.cmd([[cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/']])
vim.cmd([[cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?']])

-- Search the word that cursor is on by '*'.
vim.keymap.set('v', '*', [["vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>]])
--}}}


--{{{Display Settings..
vim.o.cursorline = true -- Highlight the current line.
vim.o.showmatch = true  -- Briefly show the matching bracket.
vim.o.matchtime = 3     -- Show the matching bracket for 3 seconds.

-- Let the TAB char appear.
--vim.o.listchars = 'tab:>-,trail:~,extends:»,precedes:«,nbsp:%'
-- Use following line, if your env does not allow unicode
--set listchars=nbsp:%
--vim.o.indentLine_color_term = 229
--vim.o.indentLine_char_list = [['|', '¦', '┆', '┊']]
--vim.o.indentLine_char = '|'
---}}}

-- vim: ts=2 sts=2 sw=2 et
