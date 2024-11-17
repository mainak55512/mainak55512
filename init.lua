-------------------------------------
-- File locations:
-- ===============
-- For Linux: /home/<user>/.config/nvim/
-- For Windows: C:\Users\<user>\AppData\Local\nvim
-------------------------------------

-- Editor settings
-- ----------------

vim.o.guifont = "Cascadia Code:h11.5" -- text below applies for VimScript
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<C-p>", ":BufferPrevious<cr>")
vim.keymap.set("n", "<C-n>", ":BufferNext<cr>")
vim.keymap.set("n", "<C-t>", ":ToggleTerm<cr>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Plugin setups
-- --------------

require("lazy").setup({
	"tpope/vim-sleuth",
	{ "m4xshen/autoclose.nvim", opts = {} },
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			require("notify").setup({
				stages = "fade_in_slide_out",
				background_colour = "FloatShadow",
				timeout = 3000,
			})
			vim.notify = require("notify")
		end,
	},
	-- {
	-- 	"folke/twilight.nvim",
	-- 	opts = {
	-- 		-- your configuration comes here
	-- 		-- or leave it empty to use the default settings
	-- 		-- refer to the configuration section below
	-- 		dimming = {
	-- 			alpha = 0.25, -- amount of dimming
	-- 			-- we try to get the foreground from the highlight groups or fallback color
	-- 			color = { "Normal", "#ffffff" },
	-- 			term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
	-- 			inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
	-- 		},
	-- 		context = 10, -- amount of lines we will try to show around the current line
	-- 		treesitter = true, -- use treesitter when available for the filetype
	-- 		-- treesitter is used to automatically expand the visible text,
	-- 		-- but you can further control the types of nodes that should always be fully expanded
	-- 		expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
	-- 			"function",
	-- 			"method",
	-- 			"table",
	-- 			"if_statement",
	-- 		},
	-- 		exclude = {}, -- exclude these filetypes
	-- 	},
	-- 	-- event = "VimEnter",
	-- 	config = function()
	-- 		require("twilight").setup({
	-- 			vim.cmd("TwilightEnable"),
	-- 		})
	-- 	end,
	-- },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"goolord/alpha-nvim",
		-- dependencies = { 'echasnovski/mini.icons' },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local startify = require("alpha.themes.startify")
			-- available: devicons, mini, default is mini
			-- if provider not loaded and enabled is true, it will try to use another provider
			startify.file_icons.provider = "devicons"

			-- Set header
			startify.section.header.val = {
				"                                                     ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
				"                                                     ",
			}
			require("alpha").setup(startify.config)
		end,
	},
	-- {
	-- 	"gelguy/wilder.nvim",
	-- 	config = function()
	-- 		local wilder = require("wilder"), wilder.setup({ modes = { ":", "/", "?" } })
	-- 	end,
	-- },
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		-- config = function()
		-- 	require("which-key").setup()
		-- 	require("which-key").register({
		-- 		["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
		-- 		["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
		-- 		["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
		-- 		["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
		-- 		["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
		-- 		["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
		-- 		["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
		-- 	})
		-- 	require("which-key").register({
		-- 		["<leader>h"] = { "Git [H]unk" },
		-- 	}, { mode = "v" })
		-- end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "wilder")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
			{ "hrsh7th/cmp-cmdline" },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
					end
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event.buf })
				end,
			})
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			}
			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
			local cmp = require("cmp")

			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<cr>"),
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
			})
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				-- Manual mode doesn't automatically change your root directory, so you have
				-- the option to manually do so using `:ProjectRoot` command.
				manual_mode = false,

				-- Methods of detecting the root directory. **"lsp"** uses the native neovim
				-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
				-- order matters: if one is not detected, the other is used as fallback. You
				-- can also delete or rearangne the detection methods.
				detection_methods = { "lsp", "pattern" },

				-- All the patterns used to detect root dir, when **"pattern"** is in
				-- detection_methods
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "go.mod" },

				-- Table of lsp clients to ignore by name
				-- eg: { "efm", ... }
				ignore_lsp = {},

				-- Don't calculate root dir on specific directories
				-- Ex: { "~/.cargo/*", ... }
				exclude_dirs = {},

				-- Show hidden files in telescope
				show_hidden = false,

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
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{
		"crispgm/nvim-tabline",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},

	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			vim.g.barbar_auto_setup = false
		end,
		version = "^1.0.0",
	},

	{
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {},
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},

	-- Theme setup
	-- -----------
	-- {
	-- 	"cpea2506/one_monokai.nvim",
	-- 	name = "one_monokai",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("one_monokai").setup({
	-- 			-- your options
	-- 		})
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				background = {
					light = "latte",
					dark = "mocha",
				},
				color_overrides = {
					latte = {
						rosewater = "#c14a4a",
						flamingo = "#c14a4a",
						red = "#c14a4a",
						maroon = "#c14a4a",
						pink = "#945e80",
						mauve = "#945e80",
						peach = "#c35e0a",
						yellow = "#b47109",
						green = "#6c782e",
						teal = "#4c7a5d",
						sky = "#4c7a5d",
						sapphire = "#4c7a5d",
						blue = "#45707a",
						lavender = "#45707a",
						text = "#654735",
						subtext1 = "#73503c",
						subtext0 = "#805942",
						overlay2 = "#8c6249",
						overlay1 = "#8c856d",
						overlay0 = "#a69d81",
						surface2 = "#bfb695",
						surface1 = "#d1c7a3",
						surface0 = "#e3dec3",
						base = "#f9f5d7",
						mantle = "#f0ebce",
						crust = "#e8e3c8",
					},
					mocha = {
						rosewater = "#ea6962",
						flamingo = "#ea6962",
						red = "#ea6962",
						maroon = "#ea6962",
						pink = "#d3869b",
						mauve = "#d3869b",
						peach = "#e78a4e",
						yellow = "#d8a657",
						green = "#a9b665",
						teal = "#89b482",
						sky = "#89b482",
						sapphire = "#89b482",
						blue = "#7daea3",
						lavender = "#7daea3",
						text = "#ebdbb2",
						subtext1 = "#d5c4a1",
						subtext0 = "#bdae93",
						overlay2 = "#a89984",
						overlay1 = "#928374",
						overlay0 = "#595959",
						surface2 = "#4d4d4d",
						surface1 = "#404040",
						surface0 = "#292929",
						base = "#1d2021",
						mantle = "#191b1c",
						crust = "#141617",
					},
				},
				transparent_background = false,
				show_end_of_buffer = false,
				integration_default = false,
				integrations = {
					barbecue = { dim_dirname = true, bold_basename = true, dim_context = false, alt_background = false },
					cmp = true,
					gitsigns = true,
					hop = true,
					illuminate = { enabled = true },
					native_lsp = { enabled = true, inlay_hints = { background = true } },
					neogit = true,
					neotree = true,
					semantic_tokens = true,
					treesitter = true,
					treesitter_context = true,
					vimwiki = true,
					which_key = true,
				},
				highlight_overrides = {
					all = function(colors)
						return {
							CmpItemMenu = { fg = colors.surface2 },
							CursorLineNr = { fg = colors.text },
							FloatBorder = { bg = colors.base, fg = colors.surface0 },
							GitSignsChange = { fg = colors.peach },
							LineNr = { fg = colors.overlay0 },
							LspInfoBorder = { link = "FloatBorder" },
							NeoTreeDirectoryIcon = { fg = colors.subtext1 },
							NeoTreeDirectoryName = { fg = colors.subtext1 },
							NeoTreeFloatBorder = { link = "TelescopeResultsBorder" },
							NeoTreeGitConflict = { fg = colors.red },
							NeoTreeGitDeleted = { fg = colors.red },
							NeoTreeGitIgnored = { fg = colors.overlay0 },
							NeoTreeGitModified = { fg = colors.peach },
							NeoTreeGitStaged = { fg = colors.green },
							NeoTreeGitUnstaged = { fg = colors.red },
							NeoTreeGitUntracked = { fg = colors.green },
							NeoTreeIndent = { fg = colors.surface1 },
							NeoTreeNormal = { bg = colors.mantle },
							NeoTreeNormalNC = { bg = colors.mantle },
							NeoTreeRootName = { fg = colors.subtext1, style = { "bold" } },
							NeoTreeTabActive = { fg = colors.text, bg = colors.mantle },
							NeoTreeTabInactive = { fg = colors.surface2, bg = colors.crust },
							NeoTreeTabSeparatorActive = { fg = colors.mantle, bg = colors.mantle },
							NeoTreeTabSeparatorInactive = { fg = colors.crust, bg = colors.crust },
							NeoTreeWinSeparator = { fg = colors.base, bg = colors.base },
							NormalFloat = { bg = colors.base },
							Pmenu = { bg = colors.mantle, fg = "" },
							PmenuSel = { bg = colors.surface0, fg = "" },
							TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
							TelescopePreviewNormal = { bg = colors.crust },
							TelescopePreviewTitle = { fg = colors.crust, bg = colors.crust },
							TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
							TelescopePromptCounter = { fg = colors.mauve, style = { "bold" } },
							TelescopePromptNormal = { bg = colors.surface0 },
							TelescopePromptPrefix = { bg = colors.surface0 },
							TelescopePromptTitle = { fg = colors.surface0, bg = colors.surface0 },
							TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
							TelescopeResultsNormal = { bg = colors.mantle },
							TelescopeResultsTitle = { fg = colors.mantle, bg = colors.mantle },
							TelescopeSelection = { bg = colors.surface0 },
							VertSplit = { bg = colors.base, fg = colors.surface0 },
							WhichKeyFloat = { bg = colors.mantle },
							YankHighlight = { bg = colors.surface2 },
							FidgetTask = { fg = colors.subtext2 },
							FidgetTitle = { fg = colors.peach },

							IblIndent = { fg = colors.surface0 },
							IblScope = { fg = colors.overlay0 },

							Boolean = { fg = colors.mauve },
							Number = { fg = colors.mauve },
							Float = { fg = colors.mauve },

							PreProc = { fg = colors.mauve },
							PreCondit = { fg = colors.mauve },
							Include = { fg = colors.mauve },
							Define = { fg = colors.mauve },
							Conditional = { fg = colors.red },
							Repeat = { fg = colors.red },
							Keyword = { fg = colors.red },
							Typedef = { fg = colors.red },
							Exception = { fg = colors.red },
							Statement = { fg = colors.red },

							Error = { fg = colors.red },
							StorageClass = { fg = colors.peach },
							Tag = { fg = colors.peach },
							Label = { fg = colors.peach },
							Structure = { fg = colors.peach },
							Operator = { fg = colors.peach },
							Title = { fg = colors.peach },
							Special = { fg = colors.yellow },
							SpecialChar = { fg = colors.yellow },
							Type = { fg = colors.yellow, style = { "bold" } },
							Function = { fg = colors.green, style = { "bold" } },
							Delimiter = { fg = colors.subtext2 },
							Ignore = { fg = colors.subtext2 },
							Macro = { fg = colors.teal },

							TSAnnotation = { fg = colors.mauve },
							TSAttribute = { fg = colors.mauve },
							TSBoolean = { fg = colors.mauve },
							TSCharacter = { fg = colors.teal },
							TSCharacterSpecial = { link = "SpecialChar" },
							TSComment = { link = "Comment" },
							TSConditional = { fg = colors.red },
							TSConstBuiltin = { fg = colors.mauve },
							TSConstMacro = { fg = colors.mauve },
							TSConstant = { fg = colors.text },
							TSConstructor = { fg = colors.green },
							TSDebug = { link = "Debug" },
							TSDefine = { link = "Define" },
							TSEnvironment = { link = "Macro" },
							TSEnvironmentName = { link = "Type" },
							TSError = { link = "Error" },
							TSException = { fg = colors.red },
							TSField = { fg = colors.blue },
							TSFloat = { fg = colors.mauve },
							TSFuncBuiltin = { fg = colors.green },
							TSFuncMacro = { fg = colors.green },
							TSFunction = { fg = colors.green },
							TSFunctionCall = { fg = colors.green },
							TSInclude = { fg = colors.red },
							TSKeyword = { fg = colors.red },
							TSKeywordFunction = { fg = colors.red },
							TSKeywordOperator = { fg = colors.peach },
							TSKeywordReturn = { fg = colors.red },
							TSLabel = { fg = colors.peach },
							TSLiteral = { link = "String" },
							TSMath = { fg = colors.blue },
							TSMethod = { fg = colors.green },
							TSMethodCall = { fg = colors.green },
							TSNamespace = { fg = colors.yellow },
							TSNone = { fg = colors.text },
							TSNumber = { fg = colors.mauve },
							TSOperator = { fg = colors.peach },
							TSParameter = { fg = colors.text },
							TSParameterReference = { fg = colors.text },
							TSPreProc = { link = "PreProc" },
							TSProperty = { fg = colors.blue },
							TSPunctBracket = { fg = colors.text },
							TSPunctDelimiter = { link = "Delimiter" },
							TSPunctSpecial = { fg = colors.blue },
							TSRepeat = { fg = colors.red },
							TSStorageClass = { fg = colors.peach },
							TSStorageClassLifetime = { fg = colors.peach },
							TSStrike = { fg = colors.subtext2 },
							TSString = { fg = colors.teal },
							TSStringEscape = { fg = colors.green },
							TSStringRegex = { fg = colors.green },
							TSStringSpecial = { link = "SpecialChar" },
							TSSymbol = { fg = colors.text },
							TSTag = { fg = colors.peach },
							TSTagAttribute = { fg = colors.green },
							TSTagDelimiter = { fg = colors.green },
							TSText = { fg = colors.green },
							TSTextReference = { link = "Constant" },
							TSTitle = { link = "Title" },
							TSTodo = { link = "Todo" },
							TSType = { fg = colors.yellow, style = { "bold" } },
							TSTypeBuiltin = { fg = colors.yellow, style = { "bold" } },
							TSTypeDefinition = { fg = colors.yellow, style = { "bold" } },
							TSTypeQualifier = { fg = colors.peach, style = { "bold" } },
							TSURI = { fg = colors.blue },
							TSVariable = { fg = colors.text },
							TSVariableBuiltin = { fg = colors.mauve },

							["@annotation"] = { link = "TSAnnotation" },
							["@attribute"] = { link = "TSAttribute" },
							["@boolean"] = { link = "TSBoolean" },
							["@character"] = { link = "TSCharacter" },
							["@character.special"] = { link = "TSCharacterSpecial" },
							["@comment"] = { link = "TSComment" },
							["@conceal"] = { link = "Grey" },
							["@conditional"] = { link = "TSConditional" },
							["@constant"] = { link = "TSConstant" },
							["@constant.builtin"] = { link = "TSConstBuiltin" },
							["@constant.macro"] = { link = "TSConstMacro" },
							["@constructor"] = { link = "TSConstructor" },
							["@debug"] = { link = "TSDebug" },
							["@define"] = { link = "TSDefine" },
							["@error"] = { link = "TSError" },
							["@exception"] = { link = "TSException" },
							["@field"] = { link = "TSField" },
							["@float"] = { link = "TSFloat" },
							["@function"] = { link = "TSFunction" },
							["@function.builtin"] = { link = "TSFuncBuiltin" },
							["@function.call"] = { link = "TSFunctionCall" },
							["@function.macro"] = { link = "TSFuncMacro" },
							["@include"] = { link = "TSInclude" },
							["@keyword"] = { link = "TSKeyword" },
							["@keyword.function"] = { link = "TSKeywordFunction" },
							["@keyword.operator"] = { link = "TSKeywordOperator" },
							["@keyword.return"] = { link = "TSKeywordReturn" },
							["@label"] = { link = "TSLabel" },
							["@math"] = { link = "TSMath" },
							["@method"] = { link = "TSMethod" },
							["@method.call"] = { link = "TSMethodCall" },
							["@namespace"] = { link = "TSNamespace" },
							["@none"] = { link = "TSNone" },
							["@number"] = { link = "TSNumber" },
							["@operator"] = { link = "TSOperator" },
							["@parameter"] = { link = "TSParameter" },
							["@parameter.reference"] = { link = "TSParameterReference" },
							["@preproc"] = { link = "TSPreProc" },
							["@property"] = { link = "TSProperty" },
							["@punctuation.bracket"] = { link = "TSPunctBracket" },
							["@punctuation.delimiter"] = { link = "TSPunctDelimiter" },
							["@punctuation.special"] = { link = "TSPunctSpecial" },
							["@repeat"] = { link = "TSRepeat" },
							["@storageclass"] = { link = "TSStorageClass" },
							["@storageclass.lifetime"] = { link = "TSStorageClassLifetime" },
							["@strike"] = { link = "TSStrike" },
							["@string"] = { link = "TSString" },
							["@string.escape"] = { link = "TSStringEscape" },
							["@string.regex"] = { link = "TSStringRegex" },
							["@string.special"] = { link = "TSStringSpecial" },
							["@symbol"] = { link = "TSSymbol" },
							["@tag"] = { link = "TSTag" },
							["@tag.attribute"] = { link = "TSTagAttribute" },
							["@tag.delimiter"] = { link = "TSTagDelimiter" },
							["@text"] = { link = "TSText" },
							["@text.danger"] = { link = "TSDanger" },
							["@text.diff.add"] = { link = "diffAdded" },
							["@text.diff.delete"] = { link = "diffRemoved" },
							["@text.emphasis"] = { link = "TSEmphasis" },
							["@text.environment"] = { link = "TSEnvironment" },
							["@text.environment.name"] = { link = "TSEnvironmentName" },
							["@text.literal"] = { link = "TSLiteral" },
							["@text.math"] = { link = "TSMath" },
							["@text.note"] = { link = "TSNote" },
							["@text.reference"] = { link = "TSTextReference" },
							["@text.strike"] = { link = "TSStrike" },
							["@text.strong"] = { link = "TSStrong" },
							["@text.title"] = { link = "TSTitle" },
							["@text.todo"] = { link = "TSTodo" },
							["@text.todo.checked"] = { link = "Green" },
							["@text.todo.unchecked"] = { link = "Ignore" },
							["@text.underline"] = { link = "TSUnderline" },
							["@text.uri"] = { link = "TSURI" },
							["@text.warning"] = { link = "TSWarning" },
							["@todo"] = { link = "TSTodo" },
							["@type"] = { link = "TSType" },
							["@type.builtin"] = { link = "TSTypeBuiltin" },
							["@type.definition"] = { link = "TSTypeDefinition" },
							["@type.qualifier"] = { link = "TSTypeQualifier" },
							["@uri"] = { link = "TSURI" },
							["@variable"] = { link = "TSVariable" },
							["@variable.builtin"] = { link = "TSVariableBuiltin" },

							["@lsp.type.class"] = { link = "TSType" },
							["@lsp.type.comment"] = { link = "TSComment" },
							["@lsp.type.decorator"] = { link = "TSFunction" },
							["@lsp.type.enum"] = { link = "TSType" },
							["@lsp.type.enumMember"] = { link = "TSProperty" },
							["@lsp.type.events"] = { link = "TSLabel" },
							["@lsp.type.function"] = { link = "TSFunction" },
							["@lsp.type.interface"] = { link = "TSType" },
							["@lsp.type.keyword"] = { link = "TSKeyword" },
							["@lsp.type.macro"] = { link = "TSConstMacro" },
							["@lsp.type.method"] = { link = "TSMethod" },
							["@lsp.type.modifier"] = { link = "TSTypeQualifier" },
							["@lsp.type.namespace"] = { link = "TSNamespace" },
							["@lsp.type.number"] = { link = "TSNumber" },
							["@lsp.type.operator"] = { link = "TSOperator" },
							["@lsp.type.parameter"] = { link = "TSParameter" },
							["@lsp.type.property"] = { link = "TSProperty" },
							["@lsp.type.regexp"] = { link = "TSStringRegex" },
							["@lsp.type.string"] = { link = "TSString" },
							["@lsp.type.struct"] = { link = "TSType" },
							["@lsp.type.type"] = { link = "TSType" },
							["@lsp.type.typeParameter"] = { link = "TSTypeDefinition" },
							["@lsp.type.variable"] = { link = "TSVariable" },
						}
					end,
					latte = function(colors)
						return {
							IblIndent = { fg = colors.mantle },
							IblScope = { fg = colors.surface1 },

							LineNr = { fg = colors.surface1 },
						}
					end,
				},
			})

			vim.api.nvim_command("colorscheme catppuccin")
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = true },
		keywords = {
			FIX = {
				icon = " ", -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		},
		gui_style = {
			fg = "NONE", -- The gui style to use for the fg highlight group.
			bg = "BOLD", -- The gui style to use for the bg highlight group.
		},
	},

	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.surround").setup()
			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "bash", "c", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
