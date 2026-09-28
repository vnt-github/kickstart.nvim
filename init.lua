--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options
-- ============================================================
do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Set to true if you have a Nerd Font installed and selected in the terminal
  vim.g.have_nerd_font = false

  -- [[ Setting options ]]
  -- Disable EditorConfig formatting on save and trailing newline injection
  vim.g.editorconfig = false
  vim.opt.fixendofline = false

  --  See `:help vim.o`
  -- NOTE: You can change these options as you wish!
  --  For more options, you can see `:help option-list`

  -- Make line numbers default
  vim.o.number = true
  -- You can also add relative line numbers, to help with jumping.
  --  Experiment for yourself to see if you like it!
  -- vim.o.relativenumber = true

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.o.mouse = 'a'

  -- Don't show the mode, since it's already in the status line
  vim.o.showmode = false

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  -- Enable break indent
  vim.o.breakindent = true

  -- Enable undo/redo changes even after closing and reopening a file
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.o.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250

  -- Decrease mapped sequence wait time
  vim.o.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.o.splitright = true
  vim.o.splitbelow = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  --
  --  Notice listchars is set using `vim.opt` instead of `vim.o`.
  --  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
  --   See `:help lua-options`
  --   and `:help lua-guide-options`
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.o.inccommand = 'split'

  -- Show which line your cursor is on
  vim.o.cursorline = true

  -- Show the full absolute file path in a separate line (winbar) at the top of each window
  vim.o.winbar = "%F %m"

  -- Show column at 80 characters width
  vim.o.colorcolumn = '80'

  -- Minimal number of screen lines to keep above and below the cursor.
  vim.o.scrolloff = 10

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  vim.o.confirm = true
end

-- ============================================================
-- SECTION 2: KEYMAPS & AUTOCMDS
-- basic keymaps, basic autocmds
-- ============================================================
do
  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

-- ============================================================
-- SECTION 3: PLUGIN MANAGER INTRO
-- vim.pack intro, build hooks
-- ============================================================
do
  -- [[ Intro to `vim.pack` ]]
  -- `vim.pack` is a new plugin manager built into Neovim,
  --  which provides a Lua interface for installing and managing plugins.
  --
  --  See `:help vim.pack`, `:help vim.pack-examples` or the
  --  excellent blog post from the creator of vim.pack and mini.nvim:
  --  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
  --
  --  To inspect plugin state and pending updates, run
  --    :lua vim.pack.update(nil, { offline = true })
  --
  --  To update plugins, run
  --    :lua vim.pack.update()
  --
  --
  --  Throughout the rest of the config there will be examples
  --  of how to install and configure plugins using `vim.pack`.
  --
  --  In this section we set up some autocommands to run build
  --  steps for certain plugins after they are installed or updated.

  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- This autocommand runs after a plugin is installed or updated and
  --  runs the appropriate build command for that plugin if necessary.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

--- Because most plugins are hosted on GitHub, you can use the helper
--- function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- SECTION 4: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
do
  -- [[ Installing and Configuring Plugins ]]
  --
  -- To install a plugin simply call `vim.pack.add` with its git url.
  -- This will download the default branch of the plugin, which will usually be `main` or `master`
  -- You can also have more advanced specs, which we will talk about later.
  --
  -- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
  --
  -- For example, lets say we want to install `guess-indent.nvim` - a plugin for
  -- automatically detecting and setting the indentation.
  --
  -- We first install it from https://github.com/NMAC427/guess-indent.nvim
  -- and then call its `setup()` function to start it with default settings.
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  -- Here is a more advanced configuration example that passes options to `gitsigns.nvim`
  --
  -- See `:help gitsigns` to understand what each configuration key does.
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  local gitsigns = require 'gitsigns'
  gitsigns.setup {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
    -- gitsigns.nvim's recommended keymaps:
    on_attach = function(bufnr)
      -- Navigation
      vim.keymap.set('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange', buf = bufnr })

      vim.keymap.set('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange', buf = bufnr })

      -- Visual mode actions
      vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [s]tage hunk', buf = bufnr })
      vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [r]eset hunk', buf = bufnr })
      -- Normal mode actions
      vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer', buf = bufnr })
      vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer', buf = bufnr })
      vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline', buf = bufnr })
      vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'git [b]lame line', buf = bufnr })
      vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index', buf = bufnr })
      vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis '~' end, { desc = 'git [D]iff against last commit', buf = bufnr })
      vim.keymap.set('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, { desc = 'git hunk [Q]uickfix list (all files in repo)', buf = bufnr })
      vim.keymap.set('n', '<leader>hq', gitsigns.setqflist, { desc = 'git hunk [q]uickfix list (all changes in this file)', buf = bufnr })
      -- Toggles
      vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line', buf = bufnr })
      vim.keymap.set('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle git intra-line [w]ord diff', buf = bufnr })
      -- Text object
      vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'text object [i]nside [h]unk', buf = bufnr })
    end,
  }

  -- Useful plugin to show you pending keybinds.
  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
  }

  -- [[ Colorscheme ]]
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command under that to load whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  vim.pack.add { gh 'folke/tokyonight.nvim' }
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight').setup {
    styles = {
      comments = { italic = false }, -- Disable italics in comments
    },
  }

  -- Load the colorscheme here.
  -- Like many other themes, this one has different styles, and you could load
  -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  vim.cmd.colorscheme 'catppuccin'

  -- Highlight todo, notes, etc in comments
  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }

  -- [[ mini.nvim ]]
  --  A collection of various small independent plugins/modules
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  -- If a nerd font is available, load the icons module for pretty icons in various plugins.
  if vim.g.have_nerd_font then
    require('mini.icons').setup()
    -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
    MiniIcons.mock_nvim_web_devicons()
  end

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()

  -- Simple and easy statusline.
  --  You could remove this setup call if you don't like it,
  --  and try some other statusline plugin
  local statusline = require 'mini.statusline'
  -- Set `use_icons` to true if you have a Nerd Font
  statusline.setup { use_icons = vim.g.have_nerd_font }

  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v' end

  -- ... and there is more!
  --  Check out: https://github.com/nvim-mini/mini.nvim
end

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- Telescope setup, keymaps, LSP picker mappings
-- ============================================================
do
  -- [[ Fuzzy Finder (files, lsp, etc) ]]
  --
  -- Telescope is a fuzzy finder that comes with a lot of different things that
  -- it can fuzzy find! It's more than just a "file finder", it can search
  -- many different aspects of Neovim, your workspace, LSP, and more!
  --
  -- There are lots of other alternative pickers (like snacks.picker, or fzf-lua)
  -- so feel free to experiment and see what you like!
  --
  -- The easiest way to use Telescope, is to start by doing something like:
  --  :Telescope help_tags
  --
  -- After running this command, a window will open up and you're able to
  -- type in the prompt window. You'll see a list of `help_tags` options and
  -- a corresponding preview of the help.
  --
  -- Two important keymaps to use while in Telescope are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  --
  -- This opens a window that shows you all of the keymaps for the current
  -- Telescope picker. This is really useful to discover what Telescope can
  -- do as well as how to actually do it!

  ---@type (string | vim.pack.Spec)[]
  local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
    gh 'nvim-telescope/telescope-live-grep-args.nvim',
  }
  if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end

  -- NOTE: You can install multiple plugins at once
  vim.pack.add(telescope_plugins)

  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    defaults = {
      path_display = { 'filename_first' },
      sorting_strategy = 'ascending',
      layout_strategy = 'vertical',
      layout_config = {
        vertical = {
          mirror = true,
          preview_height = 0.65,
          prompt_position = 'top',
          preview_cutoff = 0,
        },
        height = 0.9999,
        width = 0.9999,
      },
    },
    pickers = {
      find_files = {
        follow = true,
        no_ignore = true,
      },
      live_grep = {
        additional_args = function()
          return { '--follow', '--no-ignore' }
        end,
      },
      grep_string = {
        additional_args = function()
          return { '--follow', '--no-ignore' }
        end,
      },
    },
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--follow",
          "--no-ignore"
        },
        mappings = { -- extend mappings
          i = {
            ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
            ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
          },
        },
      },
    },
  }

  -- Enable Telescope extensions if they are installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')
  pcall(require('telescope').load_extension, 'live_grep_args')

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', function()
    require('telescope').extensions.live_grep_args.live_grep_args({
      previewer = true,
      layout_config = {
        vertical = {
          preview_cutoff = 0,
        },
      },
    })
  end, { desc = '[S]earch by [G]rep (with args)' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
  -- If you later switch picker plugins, this is where to update these mappings.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf

      -- Find references for the word under your cursor.
      vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

      -- Jump to the implementation of the word under your cursor.
      -- Useful when your language has ways of declaring types without an actual implementation.
      --
      -- NOTE: `gri` is *only* for interface/abstract methods. On a plain Go function,
      -- gopls answers "... is a function, not a method" and nothing is opened.
      -- Use `grd` below to jump to a function definition. If you instead see
      -- "method textDocument/implementation is not supported by any server activated for this
      -- buffer", that means no LSP client is attached at all -- check `:checkhealth vim.lsp`.
      vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

      -- Jump to the definition of the word under your cursor.
      -- This is where a variable was first declared, or where a function is defined, etc.
      -- To jump back, press <C-t>.
      vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

      -- Fuzzy find all the symbols in your current document.
      -- Symbols are things like variables, functions, types, etc.
      vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

      -- Fuzzy find all the symbols in your current workspace.
      -- Similar to document symbols, except searches over your entire project.
      vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

      -- Jump to the type of the word under your cursor.
      -- Useful when you're not sure what type a variable is and you want to see
      -- the definition of its *type*, not where it was *defined*.
      vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
    end,
  })

  -- Override default behavior and theme when searching
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set(
    'n',
    '<leader>s/',
    function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    { desc = '[S]earch [/] in Open Files' }
  )

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = '[S]earch [N]eovim files' })
end

-- ============================================================
-- SECTION 6: LSP
-- LSP keymaps, server configuration, Mason tools installations
-- ============================================================
do
  -- [[ LSP Configuration ]]
  -- Brief aside: **What is LSP?**
  --
  -- LSP is an initialism you've probably heard, but might not understand what it is.
  --
  -- LSP stands for Language Server Protocol. It's a protocol that helps editors
  -- and language tooling communicate in a standardized fashion.
  --
  -- In general, you have a "server" which is some tool built to understand a particular
  -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
  -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
  -- processes that communicate with some "client" - in this case, Neovim!
  --
  -- LSP provides Neovim with features like:
  --  - Go to definition
  --  - Find references
  --  - Autocompletion
  --  - Symbol Search
  --  - and more!
  --
  -- Thus, Language Servers are external tools that must be installed separately from
  -- Neovim. This is where `mason` and related plugins come into play.
  --
  -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
  -- and elegantly composed help section, `:help lsp-vs-treesitter`

  -- Configure LSP handlers to use rounded borders for float windows (Hover, Signature)
  -- Configure LSP handlers to use rounded borders and open above the cursor
  vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx, config)
    config = config or {}
    config.border = 'rounded'
    local f_bufnr, f_winnr = vim.lsp.handlers.hover(err, result, ctx, config)
    if f_winnr and vim.api.nvim_win_is_valid(f_winnr) then
      pcall(vim.api.nvim_win_set_config, f_winnr, { relative = 'cursor', anchor = 'SW', row = 0, col = 0 })
    end
    return f_bufnr, f_winnr
  end

  vim.lsp.handlers['textDocument/signatureHelp'] = function(err, result, ctx, config)
    config = config or {}
    config.border = 'rounded'
    return vim.lsp.handlers.signature_help(err, result, ctx, config)
  end

  -- Useful status updates for LSP.
  vim.pack.add { gh 'j-hui/fidget.nvim' }
  require('fidget').setup {}

  --  This function gets run when an LSP attaches to a particular buffer.
  --    That is to say, every time a new file is opened that is associated with
  --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  --    function will be executed to configure the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      local offset_encoding = client and client.offset_encoding or 'utf-16'

      -- Automatically generate a workspace-specific .clangd file if a C/C++ workspace is opened
      if client and client.name == 'clangd' then
        -- Find workspace root directory by searching upwards for standard root markers (.git, .repo)
        local function find_workspace_root(start_dir)
          local dir = start_dir
          local git_root = nil
          while dir and dir ~= "/" and dir ~= "" do
            if vim.uv.fs_stat(dir .. '/.repo') then
              return dir
            end
            if not git_root and (vim.uv.fs_stat(dir .. '/.git') or vim.uv.fs_stat(dir .. '/.repo')) then
              git_root = dir
            end
            dir = vim.fs.dirname(dir)
          end
          return git_root
        end
        
        local current_file_path = vim.api.nvim_buf_get_name(event.buf)
        if current_file_path and current_file_path ~= "" then
          local current_dir = vim.fs.dirname(current_file_path)
          local root_dir = find_workspace_root(current_dir)
          
          if root_dir then
            local clangd_file = root_dir .. '/.clangd'
            local has_clangd = vim.uv.fs_stat(clangd_file)
            
            local needs_update = true
            if has_clangd then
              local f_read = io.open(clangd_file, "r")
              if f_read then
                local content = f_read:read("*all")
                f_read:close()
                -- If it's already using our absolute paths, skip updating
                if content:find(root_dir, 1, true) then
                  needs_update = false
                end
              end
            end
            
            if needs_update then
              local lines = {
                "CompileFlags:",
                "  Add:",
              }
              
              -- 1. Gather all global include directories at depth <= 4 from the root
              local global_includes = {}
              local function walk(dir, depth)
                if depth > 4 then return end
                local handle = vim.uv.fs_scandir(dir)
                if not handle then return end
                while true do
                  local name, type = vim.uv.fs_scandir_next(handle)
                  if not name then break end
                  if type == 'directory' then
                    local child_path = dir .. '/' .. name
                    if name ~= '.git' and name ~= '.repo' and name ~= '.ez' and name ~= 'node_modules' and name ~= 'output' and name ~= 'Build' then
                      local lower_name = name:lower()
                      if lower_name == 'include' or lower_name == 'includes' or lower_name == 'inc' then
                        table.insert(global_includes, child_path)
                      end
                      walk(child_path, depth + 1)
                    end
                  end
                end
              end
              walk(root_dir, 1)
              
              -- 2. Gather local include directories by walking up from the current file
              local local_includes = {}
              local dir = current_dir
              while dir and dir ~= "/" and dir ~= "" do
                local handle = vim.uv.fs_scandir(dir)
                if handle then
                  while true do
                    local name, type = vim.uv.fs_scandir_next(handle)
                    if not name then break end
                    if type == 'directory' then
                      local lower = name:lower()
                      if lower == 'include' or lower == 'includes' or lower == 'inc' then
                        table.insert(local_includes, dir .. '/' .. name)
                      end
                    end
                  end
                end
                if dir == root_dir then break end
                dir = vim.fs.dirname(dir)
              end
              
              -- 3. Find the AutoGen.h directory for the current module if present under Build
              local autogen_dir = nil
              local module_name = nil
              for segment in current_file_path:gmatch("[^/]+") do
                if segment:find("Dxe") or segment:find("Pei") or segment:find("Smm") or segment:find("Lib") then
                  module_name = segment
                  break
                end
              end
              if not module_name then
                module_name = current_file_path:match("([^/]+)%.c$")
              end
              if module_name then
                local build_path = root_dir .. '/Build'
                if vim.uv.fs_stat(build_path) then
                  local matches = vim.fs.find('AutoGen.h', { path = build_path, limit = 500 })
                  for _, path in ipairs(matches) do
                    if path:find("/" .. module_name .. "/") then
                      autogen_dir = vim.fs.dirname(path)
                      break
                    end
                  end
                end
              end
              
              -- 4. Consolidate and deduplicate include lines
              local seen = {}
              local function add_include(path)
                if not seen[path] then
                  seen[path] = true
                  table.insert(lines, "    - -I" .. path)
                end
              end
              
              -- Prioritize local and autogen includes
              if autogen_dir then add_include(autogen_dir) end
              for _, path in ipairs(local_includes) do add_include(path) end
              for _, path in ipairs(global_includes) do add_include(path) end
              
              -- Also add dynamic architecture include paths if we detect X64/x64 or similar
              local edk2_dir = vim.uv.fs_stat(root_dir .. '/edk2') and 'edk2' or 'Edk2'
              local x64_path = root_dir .. '/' .. edk2_dir .. '/MdePkg/Include/X64'
              if vim.uv.fs_stat(x64_path) then
                add_include(x64_path)
              end
              
              -- Add standard compiler and preprocessor flags
              local tail = {
                "    - -std=c99",
                "    - -fshort-wchar",
                "    - -include",
                "    - PiDxe.h"
              }
              for _, line in ipairs(tail) do
                table.insert(lines, line)
              end
              
              local f = io.open(clangd_file, "w")
              if f then
                f:write(table.concat(lines, "\n") .. "\n")
                f:close()
                vim.notify("Auto-generated .clangd for workspace: " .. root_dir, vim.log.levels.INFO)
                pcall(vim.cmd, "LspRestart")
              end
            end
          end
        end
      end

      -- NOTE: Remember that Lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- Custom smart hover function that combines standard hover and typeDefinition hover.
      -- This allows variables, struct fields, and functions pointers (like gBS->LoadImage)
      -- to display their complete underlying function signatures and parameters directly in hover!
      local function hover_combined()
        local bufnr = vim.api.nvim_get_current_buf()
        local params = vim.lsp.util.make_position_params(0, offset_encoding)
        
        local standard_hover_res = nil
        local type_hover_res = nil
        local done_count = 0
        
        -- Helper function to extract preceding doc comments for macros from source files
        local function get_macro_doc_from_def(path, line_idx)
          local f = io.open(path, "r")
          if not f then return nil end
          local file_lines = {}
          for line in f:lines() do
            table.insert(file_lines, line)
          end
          f:close()
          
          local macro_line = line_idx + 1
          if macro_line > #file_lines then return nil end
          
          local comment_lines = {}
          local in_comment = false
          for i = macro_line - 1, 1, -1 do
            local line = file_lines[i]
            if line:find("//", 1, true) or line:find("///", 1, true) then
              table.insert(comment_lines, 1, line)
            elseif line:find("*/", 1, true) then
              in_comment = true
              table.insert(comment_lines, 1, line)
              if line:find("/*", 1, true) then
                -- Single-line block comment, e.g. /* comment */
                break
              end
            elseif in_comment then
              table.insert(comment_lines, 1, line)
              if line:find("/*", 1, true) then
                -- Start of block comment
                break
              end
            else
              if line:match("^%s*$") then
                -- continue
              else
                break
              end
            end
          end
          
          if vim.tbl_isempty(comment_lines) then return nil end
          
          local clean_lines = {}
          for _, line in ipairs(comment_lines) do
            local cleaned = line:gsub("^%s*///%s*", ""):gsub("^%s*//%s*", ""):gsub("^%s*/%*%*%s*", ""):gsub("^%s*/%*%s*", ""):gsub("^%s*%*%*/%s*$", ""):gsub("^%s*%*/%s*$", ""):gsub("^%s*%*%s*@param%s+", "* **Param:** "):gsub("^%s*%*%s*@return%s+", "* **Return:** "):gsub("^%s*%*%s*@retval%s+", "* **RetVal:** "):gsub("^%s*%*%s*", ""):gsub("%s*$", "")
            if cleaned ~= "" then
              table.insert(clean_lines, cleaned)
            end
          end
          
          return table.concat(clean_lines, "\n")
        end
        
        local function display_results()
          if not standard_hover_res then
            vim.lsp.buf.hover()
            return
          end
          
          local function get_markdown(res)
            if type(res.contents) == 'string' then
              return res.contents
            elseif type(res.contents) == 'table' then
              if res.contents.kind == 'markdown' then
                return res.contents.value
              else
                return table.concat(res.contents, '\n')
              end
            end
            return ""
          end

          local std_md = get_markdown(standard_hover_res)
          
          if not type_hover_res then
            vim.lsp.handlers['textDocument/hover'](nil, standard_hover_res, { method = 'textDocument/hover', bufnr = bufnr }, {})
            return
          end
          
          local type_md = get_markdown(type_hover_res)
          
          -- Strip any overlapping prefix title from type definition hover to make it flow beautifully
          type_md = type_md:gsub("^### type%-alias `.-`\n\n%-%-%-\n", "")
          
          local combined_md = std_md .. '\n\n---\n### Underlying Type Definition:\n' .. type_md
          local combined_res = {
            contents = {
              kind = 'markdown',
              value = combined_md
            }
          }
          
          vim.lsp.handlers['textDocument/hover'](nil, combined_res, { method = 'textDocument/hover', bufnr = bufnr }, {})
        end
        
        local function check_done()
          done_count = done_count + 1
          if done_count == 2 then
            display_results()
          end
        end
        
        -- 1. Query standard hover
        vim.lsp.buf_request(bufnr, 'textDocument/hover', params, function(err, result, ctx, config)
          if not err and result and result.contents then
            standard_hover_res = result
            
            local std_md = result.contents.value or (type(result.contents) == 'string' and result.contents) or ""
            local header = std_md:match("### macro [^\n]+")
            local macro_name = header and header:match("([%%a_][%%a%%d_]*)")
            if macro_name then
              -- We are querying the macro definition location to extract doc comments
              done_count = done_count - 1
              vim.lsp.buf_request(bufnr, 'textDocument/definition', params, function(def_err, def_result, def_ctx, def_config)
                if not def_err and def_result and not vim.tbl_isempty(def_result) then
                  local target = def_result[1]
                  local target_uri = target.uri or target.targetUri
                  local target_range = target.range or target.targetSelectionRange
                  if target_uri and target_range then
                    local path = vim.uri_to_fname(target_uri)
                    local doc = get_macro_doc_from_def(path, target_range.start.line)
                    if doc then
                      std_md = std_md .. '\n\n---\n### Direct Definition Documentation:\n' .. doc
                      if type(standard_hover_res.contents) == 'table' and standard_hover_res.contents.kind == 'markdown' then
                        standard_hover_res.contents.value = std_md
                      else
                        standard_hover_res.contents = { kind = 'markdown', value = std_md }
                      end
                    end
                  end
                end
                check_done()
              end)
            end
          end
          check_done()
        end)
        
        -- 2. Query type definition
        vim.lsp.buf_request(bufnr, 'textDocument/typeDefinition', params, function(err, result, ctx, config)
          if err or not result or vim.tbl_isempty(result) then
            check_done()
            return
          end
          
          local target = result[1]
          if not target then
            check_done()
            return
          end
          
          local target_uri = target.uri or target.targetUri
          local target_range = target.range or target.targetSelectionRange
          if not target_uri or not target_range then
            check_done()
            return
          end
          
          -- Avoid fetching type hover if it points to the exact same position as standard hover
          if target_uri == params.textDocument.uri and 
             target_range.start.line == params.position.line and 
             math.abs(target_range.start.character - params.position.character) <= 3 then
            check_done()
            return
          end
          
          -- Prepare buffer without creating or checking swapfiles
          local path = vim.uri_to_fname(target_uri)
          local target_bufnr = vim.fn.bufadd(path)
          vim.bo[target_bufnr].swapfile = false
          vim.fn.bufload(target_bufnr)
          
          -- Make sure the buffer is attached to active client
          local client_id = event.data.client_id
          vim.lsp.buf_attach_client(target_bufnr, client_id)
          
          local hover_params = {
            textDocument = { uri = target_uri },
            position = {
              line = target_range.start.line,
              character = target_range.start.character,
            }
          }
          
          vim.lsp.buf_request(target_bufnr, 'textDocument/hover', hover_params, function(hover_err, hover_res, hover_ctx, hover_cfg)
            if not hover_err and hover_res and hover_res.contents then
              type_hover_res = hover_res
            end
            check_done()
          end)
        end)
      end

      -- Show documentation / hover pop-up for the definition under your cursor.
      --  See `:help K` or `:help vim.lsp.buf.hover()`
      map('K', hover_combined, 'Hover Documentation')

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- ------------------------------------------------------------------
  -- gopls root resolution
  -- ------------------------------------------------------------------
  -- Goal: root gopls at the *nearest* enclosing Go module or workspace, never at
  -- a parent `.git`/`.repo` checkout that contains no go.mod. In multi-repo
  -- workspaces where Go code lives in nested subdirectories, nvim-lspconfig's
  -- stock resolver:
  --   vim.fs.root(fname,'go.work') or vim.fs.root(fname,'go.mod') or vim.fs.root(fname,'.git')
  -- prefers a `go.work` found ANYWHERE up the tree over a closer `go.mod`. Using
  -- `vim.fs.root(fname, { 'go.mod', 'go.work' })` checks both markers at each
  -- directory level before walking up, guaranteeing we root at the nearest Go
  -- module or workspace.
  --
  -- IMPORTANT: we must still reproduce upstream's GOMODCACHE / GOROOT handling.
  -- Files under the module cache or the Go stdlib each sit next to their own
  -- go.mod, so a naive "nearest go.mod" resolver would spawn a *second* gopls
  -- rooted inside the read-only module cache (or at $GOROOT/src) the moment you
  -- `grd` into a dependency. Upstream avoids that by reusing the root_dir of the
  -- gopls that is already running. See nvim-lspconfig lsp/gopls.lua and
  -- https://github.com/neovim/nvim-lspconfig/issues/804
  local go_dirs = nil
  local function get_go_dirs()
    if go_dirs then return go_dirs end
    go_dirs = { modcache = '', goroot = '' }
    -- Resolved once, lazily, on the first Go buffer (not on startup).
    -- GOWORK=off so this cannot fail because of an unrelated workspace file.
    local ok, res = pcall(function() return vim.system({ 'go', 'env', 'GOMODCACHE', 'GOROOT' }, { text = true, env = { GOWORK = 'off' } }):wait(5000) end)
    if ok and res and res.code == 0 then
      local lines = vim.split(vim.trim(res.stdout or ''), '\n', { trimempty = true })
      go_dirs.modcache = lines[1] and vim.fs.normalize(vim.trim(lines[1])) or ''
      go_dirs.goroot = lines[2] and vim.fs.normalize(vim.trim(lines[2])) or ''
    end
    return go_dirs
  end

  ---@param bufnr integer
  ---@param on_dir fun(dir: string?)
  local function gopls_root_dir(bufnr, on_dir)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname == '' then return end
    local fname = vim.fs.normalize(bufname)

    local dirs = get_go_dirs()
    local function is_under(dir) return dir ~= '' and fname:sub(1, #dir + 1) == dir .. '/' end
    if is_under(dirs.modcache) or is_under(dirs.goroot) then
      local clients = vim.lsp.get_clients { name = 'gopls' }
      if #clients > 0 then
        -- Attach read-only dependency/stdlib files to the gopls that sent us here.
        return on_dir(clients[#clients].config.root_dir)
      end
    end

    -- Nearest ancestor holding either marker wins (vim.fs.root checks every
    -- marker at each directory level before walking up), so a nested module
    -- still gets its own root.
    on_dir(vim.fs.root(fname, { 'go.mod', 'go.work' }))
  end

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --  See `:help lsp-config` for information about keys and how to configure
  ---@type table<string, vim.lsp.Config>
  local servers = {
    clangd = {},
    gopls = {
      -- Keep `go.work` files scoped to individual module roots rather than placing
      -- a global `~/go.work` in $HOME (since the Go toolchain walks up the
      -- directory tree to discover `go.work`). Do not force `GOWORK=off` here so
      -- per-checkout `go.work` files are respected by gopls.
      cmd = { 'gopls' },

      -- See gopls_root_dir above. NOTE: the signature must be (bufnr, on_dir) for
      -- `vim.lsp.Config` on Neovim 0.11+; the legacy `function(fname) return ... end`
      -- form silently never starts the server.
      root_dir = gopls_root_dir,

      settings = {
        gopls = {
          expandWorkspaceToModule = false,
        },
      },
    },
    pyright = {},
    -- tsc = {},
    --
    -- Some languages (like rust) have entire language plugins that can be useful:
    --    https://github.com/mrcjkb/rustaceanvim
    --
    -- But for many setups, the LSP (`rust_analyzer`) will work just fine
    rust_analyzer = {},

    stylua = {}, -- Used to format Lua code

    -- Special Lua Config, as recommended by neovim help docs
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
        client.config.settings.Lua = vim.tbl_deep_extend('force', current_settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
            library = vim.api.nvim_get_runtime_file('', true),
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false }, -- Disable formatting (formatting is done by stylua)
        },
      },
    },
  }

  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  -- Automatically install LSPs and related tools to stdpath for Neovim
  require('mason').setup {}

  -- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
  require('mason-lspconfig').setup {
    automatic_enable = false, -- Change this to true if you want to automatically enable servers that are installed manually (e.g. via :Mason / :MasonInstall)
  }

  -- Ensure the servers and tools above are installed
  --
  -- To check the current status of installed tools and/or manually install
  -- other tools, you can run
  --    :Mason
  --
  -- You can press `g?` for help in this menu.
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- You can add other tools here that you want Mason to install
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  -- Register + enable the servers.
  --
  -- WHY NOT `lspconfig[name].setup()`:
  --   The previous code was
  --     local configs = require('lspconfig.configs')
  --     for name, server in pairs(servers) do
  --       if configs[name] then lspconfig[name].setup(server) end
  --     end
  --   That is dead code twice over on the installed nvim-lspconfig (2.x):
  --     1. `lspconfig.configs` is `setmetatable({}, { __newindex = ... })` -- it defines NO
  --        `__index`, and `require('lspconfig')` populates it only lazily, on `lspconfig.<name>`
  --        access. So `configs[name]` is nil for every server, the `if` never passes, and
  --        `setup()` was never called for ANY server -- no LSP client ever started. That is the
  --        real reason gopls appeared "not attached" / "method not supported by any server".
  --     2. Even forcing the branch would not help: `lua/lspconfig/configs/` no longer exists in
  --        2.x, so `lspconfig.gopls` would warn '[lspconfig] config "gopls" not found' and hand
  --        back a no-op `{ setup = function() end }`.
  --
  -- Neovim 0.12 ships the native config API, and nvim-lspconfig ships its per-server defaults as
  -- `lsp/<name>.lua` on the runtimepath. `vim.lsp.config(name, opts)` merges our overrides on top
  -- of those defaults, and `vim.lsp.enable(name)` wires up the FileType autocmd that starts it.
  -- (blink.cmp injects completion `capabilities` for every server via its own
  -- `vim.lsp.config('*', ...)` in plugin/blink-cmp.lua, so nothing to do here.)
  local to_enable = {}
  for name, server in pairs(servers) do
    -- Only enable names we can actually launch: either nvim-lspconfig ships an `lsp/<name>.lua`
    -- for them, or this table supplies its own `cmd`. Anything else (a typo, or a pure CLI tool
    -- listed here just so mason-tool-installer installs it) would register a config that can
    -- never start.
    --
    -- NOTE: `stylua` DOES pass this check and is intentionally started. nvim-lspconfig ships
    -- `lsp/stylua.lua` (stylua has an `--lsp` mode), and it is what actually formats Lua here:
    -- lua_ls formatting is disabled above, and conform.nvim has no `lua` entry in
    -- formatters_by_ft, so `<leader>f` reaches stylua through conform's `lsp_format='fallback'`.
    -- If you would rather not run stylua as a server, add `lua = { 'stylua' }` to
    -- `formatters_by_ft` in SECTION 7 and drop `stylua` from this table.
    if server.cmd or #vim.api.nvim_get_runtime_file('lsp/' .. name .. '.lua', false) > 0 then
      vim.lsp.config(name, server)
      table.insert(to_enable, name)
    end
  end
  if #to_enable > 0 then vim.lsp.enable(to_enable) end

end

-- ============================================================
-- SECTION 7: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================
do
  -- [[ Formatting ]]
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- You can specify filetypes to autoformat on save here:
      local enabled_filetypes = {
        -- lua = true,
        -- python = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      -- rust = { 'rustfmt' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
end

-- ============================================================
-- SECTION 8: AUTOCOMPLETE & SNIPPETS
-- blink.cmp and luasnip setup
-- ============================================================
do
  -- [[ Snippet Engine ]]

  -- NOTE: You can also specify plugin using a version range for its git tag.
  --  See `:help vim.version.range()` for more info
  vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
  require('luasnip').setup {}

  -- `friendly-snippets` contains a variety of premade snippets.
  --    See the README about individual language/framework/plugin snippets:
  --    https://github.com/rafamadriz/friendly-snippets
  --
  -- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
  -- require('luasnip.loaders.from_vscode').lazy_load()

  -- [[ Autocomplete Engine ]]
  vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
  require('blink.cmp').setup {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See `:help blink-cmp-config-keymap` for defining your own keymap
      preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See `:help blink-cmp-config-fuzzy` for more information
    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  }
end

-- ============================================================
-- SECTION 9: TREESITTER
-- Parser installation, syntax highlighting, folds, indentation
-- ============================================================
do
  -- [[ Configure Treesitter ]]
  --  Used to highlight, edit, and navigate code
  --
  --  See `:help nvim-treesitter-intro`

  -- NOTE: You can also specify a branch or a specific commit
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  -- Ensure basic parsers are installed
  local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
  require('nvim-treesitter').install(parsers)

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    -- Check if a parser exists and load it
    if not vim.treesitter.language.add(language) then return end

    -- Check if the buffer is valid (might not be after install completes)
    if not vim.api.nvim_buf_is_valid(buf) then return end

    -- Enable syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)

    -- Enable treesitter based folds
    -- For more info on folds see `:help folds`
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'

    -- Check if treesitter indentation is available for this language, and if so enable it
    -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    -- Enable treesitter based indentation
    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

      if vim.tbl_contains(installed_parsers, language) then
        -- Enable the parser if it is already installed
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

-- ============================================================
-- SECTION 10: OPTIONAL EXAMPLES / NEXT STEPS
-- kickstart.plugins.* examples
-- ============================================================
do
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug'
  -- require 'kickstart.plugins.indent_line'
  -- require 'kickstart.plugins.lint'
  -- require 'kickstart.plugins.autopairs'
  -- require 'kickstart.plugins.neo-tree'

  -- NOTE: You can add your own plugins, configuration, etc. in `lua/custom/plugins/*.lua`.
  --
  -- For independent modules, uncomment the convenience loader:
  require 'custom.plugins'
  --
  -- `custom.plugins` automatically loads files from that directory, but their
  -- order is unspecified. If plugins depend on each other, keep them in the same
  -- file and put their `vim.pack.add()` and `setup()` calls in the required order.
  --
  -- If separate modules need a specific order, require them explicitly instead:
  -- require 'custom.plugins.colorscheme'
  -- require 'custom.plugins.ui'
  -- require 'custom.plugins.git'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
