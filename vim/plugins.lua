-- ~/.config/nvim/lua/plugins.lua
return {
  {
    "vim-scripts/mru.vim",
    keys = {
      { "<leader>r", ":MRU<CR>", desc = "Open recent files window" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python",
          "lua",
          "vim",
          "bash",
          "javascript",
          "typescript",
          "html",
          "css",
          "scss",
          "vue",
          "json",
          "markdown",
          "yaml",
          "c",
          "cpp",
          "java",
          "rust",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<TAB>",
            node_decremental = "<BS>",
          },
        },
        fold = {
          enable = true,
        },
        indent = {
          enable = true
        },
        autotag = {
          enable = true
        },
        context_commentstring = {
          enable = true
        },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lsp = require("mason-lspconfig")

      -- Setup Mason (LSP installer)
      require("mason").setup()

      -- Attach actions on LSP attach
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, desc = "LSP: " }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end

      -- Manually setup each LSP
      lspconfig.volar.setup({
          on_attach = on_attach,
          filetypes = {
              "typescript", "javascript",
              "javascriptreact", "typescriptreact",
              "vue", "json"
          },
      })

      lspconfig.ts_ls.setup({
          on_attach = on_attach,
      })

      lspconfig.eslint.setup({
          on_attach = function(client, bufnr)
              client.server_capabilities.documentFormattingProvider = false
              on_attach(client, bufnr)
          end,
      })

      -- Enable Pyright for Python
      lspconfig.pyright.setup({
        filetypes = { "python" },
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              -- Optional: specify Python interpreter
              -- pythonPath = "/path/to/your/venv/bin/python",
            },
          },
        },
      })
    end,
  },

  -- Mason (LSP/Formatter installer)
  {
    "williamboman/mason.nvim",
    config = true,
  },

  -- Auto complete
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP completion
      "hrsh7th/cmp-buffer",       -- Buffer completion
      "hrsh7th/cmp-path",         -- Path completion
      "hrsh7th/cmp-cmdline",      -- Command line completion
      "L3MON4D3/LuaSnip",         -- Snippets engine
      "saadparwaiz1/cmp_luasnip", -- Snippets completion
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Enable ⌨️ (icons), and kind kind for more context
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Define sources and their order
        sources = cmp.config.sources({
          { name = "nvim_lsp" },      -- LSP (e.g., pyright, tsserver)
          { name = "luasnip" },       -- Snippets
          { name = "buffer" },        -- Text in current buffer
          { name = "path" },          -- File paths
        }),

        -- Set up key mappings
        mapping = cmp.mapping.preset.insert({
          -- Navigate items
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Confirm selection
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),

          -- Expand or jump forward in snippet
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),

          -- Jump backward in snippet
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),

          -- Scroll docs
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        -- Customize formatting
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = ({
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰂡",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "󰗴",
            })[vim_item.kind] or vim_item.kind

            -- Source
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]

            return vim_item
          end,
        },
      })

      -- Enable command-line completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- Optional: Load friendly snippets
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-nvim-lsp-signature-help",

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",        -- Required async library
      "nvim-telescope/telescope-fzf-native.nvim",  -- Optional: Faster filtering
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          -- Show preview, results, and prompt side by side
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            width = 0.87,
            height = 0.80,
          },

          -- Enable prompt reset
          mappings = {
            i = {
              ["<Esc>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },

          -- Use ripgrep for live grep
          file_ignore_patterns = { "node_modules", ".git/" },
        },

        -- Extensions configuration
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          },
        },
      })

      -- Load FZF native support (optional but faster)
      pcall(telescope.load_extension, "fzf")

      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep (search text)" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List open buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help pages" })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Recent files" })
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = "Document symbols" })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = "Show diagnostics" })
      vim.keymap.set('n', '<leader>fc', builtin.git_status, { desc = "Git status" })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Git branches" })
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },

  {
    "nvim-telescope/telescope-project.nvim",
    config = function()
      require("telescope").load_extension("project")
    end,
  },

  -- Formatter & Linter
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,        -- Python
          null_ls.builtins.formatting.isort,        -- Python imports
          null_ls.builtins.formatting.prettier,     -- JS/TS/Json/Html
          null_ls.builtins.formatting.shfmt,        -- Shell scripts
          null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.diagnostics.eslint_d,    -- JS/TS
          null_ls.builtins.diagnostics.shellcheck,  -- Shell
          null_ls.builtins.diagnostics.flake8,      -- Python
          null_ls.builtins.code_actions.gitsigns,   -- Git actions
          null_ls.builtins.code_actions.refactoring,-- Refactoring
        },
        -- format on save
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },

  -- Virtualenv
  {
    "AckslD/swenv.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>ve", "<cmd>SWEnvSelect<CR>", { desc = "Select Python Env" })
      vim.keymap.set("n", "<leader>va", "<cmd>SWEnvAuto<CR>", { desc = "Auto-select Env" })
    end,
  },

  -- Docstrings & Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets"
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local gs = require("gitsigns")

      gs.setup({
        signs = {
          add          = { text = "│" },
          change       = { text = "│" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
          untracked    = { text = "┆" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`

        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },

        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
          delay = 1000,
          ignore_whitespace = false,
        },

        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",

        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,

        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },

        yadm = {
          enable = false,
        },
      })
    end,
  },

  -- Git
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = {
      { "<leader>gs", ":Gstatus<cr>", desc = "Git Status" },
      { "<leader>gb", ":Gblame<cr>", desc = "Git Blame" },
      { "<leader>gd", ":Gdiffsplit<cr>", desc = "Diffsplit" },
      { "<leader>gc", ":Git commit<cr>", desc = "Git Commit" },
      { "<leader>gw", ":Gwrite<cr>", desc = "Git Write (save to index)" },
    },
  },

  -- File explorer
  { "nvim-tree/nvim-web-devicons" },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- Optional: for file icons
    },
    cmd = { "NvimTreeToggle", "NvimTreeOpen" },
    config = function()
      local nvim_tree = require("nvim-tree")

      nvim_tree.setup({
        -- Disable window_picker
        disable_netrw = true,
        hijack_netrw = true,
        respect_buf_cwd = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          debounce_delay = 200,
        },
        view = {
          width = 30,
          side = "left",
          preserve_window_proportions = false,
        },
        renderer = {
          root_folder_label = false,
          highlight_git = true,
          highlight_opened_files = "all",
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { "node_modules", ".cache" },
        },
        git = {
          enable = true,
          ignore = true,
          timeout = 500,
        },
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
          },
        },
        trash = {
          cmd = "trash",
          require_confirm = true,
        },
      })
    end,
  },

  -- File icons
  {
    "kyazdani42/nvim-web-devicons",
    lazy = true,
  },

  -- Vue.js syntax
  {
    "posva/vim-vue",
    ft = "vue",
  },

  -- Automatically close tags in Vue/HTML
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "vue", "jsx", "tsx" },
  },

  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000
  },
}
