-- since this is just an example spec, don't actually load anything here and return an empty spec
return {
  { "darfink/vim-plist" },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,

        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        detection_methods = { "pattern", "lsp" },

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".projectrc", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},

        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = {},

        -- Show hidden files in telescope
        show_hidden = true,

        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,

        -- What scope to change the directory, valid options are
        -- * global (default)
        -- * tab
        -- * win
        scope_chdir = "global",

        -- Path where project.nvim will store the project history for use in
        -- telescope
        datapath = vim.fn.stdpath("data"),
      })
    end,
  },
}
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
-- return {
--   -- add gruvbox
--   { "ellisonleao/gruvbox.nvim" },
--
--   -- Configure LazyVim to load gruvbox
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "gruvbox",
--     },
--   },
--
--   -- change trouble config
--   {
--     "folke/trouble.nvim",
--     -- opts will be merged with the parent spec
--     opts = { use_diagnostic_signs = true },
--   },
--
--   -- disable trouble
--   { "folke/trouble.nvim", enabled = false },
--
--   -- override nvim-cmp and add cmp-emoji
--   {
--     "hrsh7th/nvim-cmp",
--     dependencies = { "hrsh7th/cmp-emoji" },
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--       table.insert(opts.sources, { name = "emoji" })
--     end,
--   },
--
--   -- change some telescope options and a keymap to browse plugin files
--   {
--     "nvim-telescope/telescope.nvim",
--     keys = {
--       -- add a keymap to browse plugin files
--       -- stylua: ignore
--       {
--         "<leader>fp",
--         function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
--         desc = "Find Plugin File",
--       },
--     },
--     -- change some options
--     opts = {
--       defaults = {
--         layout_strategy = "horizontal",
--         layout_config = { prompt_position = "top" },
--         sorting_strategy = "ascending",
--         winblend = 0,
--       },
--     },
--   },
--
--   -- add pyright to lspconfig
--   {
--     "neovim/nvim-lspconfig",
--     ---@class PluginLspOpts
--     opts = {
--       ---@type lspconfig.options
--       servers = {
--         -- pyright will be automatically installed with mason and loaded with lspconfig
--         pyright = {},
--       },
--     },
--   },
--
--   -- add tsserver and setup with typescript.nvim instead of lspconfig
--   {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--       "jose-elias-alvarez/typescript.nvim",
--       init = function()
--         require("lazyvim.util").lsp.on_attach(function(_, buffer)
--           -- stylua: ignore
--           vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
--           vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
--         end)
--       end,
--     },
--     ---@class PluginLspOpts
--     opts = {
--       ---@type lspconfig.options
--       servers = {
--         -- tsserver will be automatically installed with mason and loaded with lspconfig
--         tsserver = {},
--       },
--       -- you can do any additional lsp server setup here
--       -- return true if you don't want this server to be setup with lspconfig
--       ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
--       setup = {
--         -- example to setup with typescript.nvim
--         tsserver = function(_, opts)
--           require("typescript").setup({ server = opts })
--           return true
--         end,
--         -- Specify * to use this function as a fallback for any server
--         -- ["*"] = function(server, opts) end,
--       },
--     },
--   },
--
--   -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
--   -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
--   { import = "lazyvim.plugins.extras.lang.typescript" },
--
--   -- add more treesitter parsers
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = {
--       ensure_installed = {
--         "bash",
--         "html",
--         "javascript",
--         "json",
--         "lua",
--         "markdown",
--         "markdown_inline",
--         "python",
--         "query",
--         "regex",
--         "tsx",
--         "typescript",
--         "vim",
--         "yaml",
--       },
--     },
--   },
--
--   -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
--   -- would overwrite `ensure_installed` with the new value.
--   -- If you'd rather extend the default config, use the code below instead:
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function(_, opts)
--       -- add tsx and treesitter
--       vim.list_extend(opts.ensure_installed, {
--         "tsx",
--         "typescript",
--       })
--     end,
--   },
--
--   -- the opts function can also be used to change the default opts:
--   {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     opts = function(_, opts)
--       table.insert(opts.sections.lualine_x, "😄")
--     end,
--   },
--
--   -- or you can return new options to override all the defaults
--   {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     opts = function()
--       return {
--         --[[add your custom lualine config here]]
--       }
--     end,
--   },
--
--   -- use mini.starter instead of alpha
--   { import = "lazyvim.plugins.extras.ui.mini-starter" },
--
--   -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
--   { import = "lazyvim.plugins.extras.lang.json" },
--
--   -- add any tools you want to have installed below
--   {
--     "williamboman/mason.nvim",
--     opts = {
--       ensure_installed = {
--         "stylua",
--         "shellcheck",
--         "shfmt",
--         "flake8",
--       },
--     },
--   },
--
--   -- Use <tab> for completion and snippets (supertab)
--   {
--     "hrsh7th/nvim-cmp",
--     dependencies = {
--       "hrsh7th/cmp-emoji",
--     },
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--       local has_words_before = function()
--         unpack = unpack or table.unpack
--         local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--         return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--       end
--
--       local cmp = require("cmp")
--
--       opts.mapping = vim.tbl_extend("force", opts.mapping, {
--         ["<Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_next_item()
--           elseif vim.snippet.active({ direction = 1 }) then
--             vim.schedule(function()
--               vim.snippet.jump(1)
--             end)
--           elseif has_words_before() then
--             cmp.complete()
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_prev_item()
--           elseif vim.snippet.active({ direction = -1 }) then
--             vim.schedule(function()
--               vim.snippet.jump(-1)
--             end)
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--       })
--     end,
--   },
-- }
