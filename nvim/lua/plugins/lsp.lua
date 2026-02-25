return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim", -- handles auto-install & auto-enable
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"ccls",
					"yamlls",
					"jsonls",
					"marksman",
					"python-lsp-server",
					"jedi-language-server",
					"django-template-lsp",
					"hls",
					"ghcide",
					"bash-language-server",
					"shellcheck",
					"rust-analyzer",
					"ts_ls",
					"vscode-eslint",
				},
				automatic_enable = true, -- auto vim.lsp.enable() on install/open
				-- automatic_installation = true, -- optional: install on first filetype open
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		-- No config function here anymore — we customize below via vim.lsp
	},

	-- Optional: shared on_attach / capabilities (define once, reuse)
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- If you use nvim-cmp, load capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)  -- uncomment if using cmp

			-- Shared on_attach (keymaps, etc.)
			local on_attach = function(client, bufnr)
				-- Your keymaps here, e.g.:
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				-- add more as needed
				local opts = { buffer = bufnr }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end

			-- Customize servers that need tweaks (others use nvim-lspconfig defaults automatically)
			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = { enable = false },
					},
				},
			})

			-- Example for another server
			vim.lsp.config("pyright", {
				on_attach = on_attach,
				capabilities = capabilities,
				-- settings = { ... } if needed
			})

			-- For clangd, yamlls, etc. → if no custom settings needed, do NOTHING
			-- ma-- or "mason-org/mason.nvim" if redirectedson-lspconfig + nvim-lspconfig defaults will handle them via auto-enable

			-- If you want to force-enable some right now (usually not needed)
			-- vim.lsp.enable({ "lua_ls", "pyright" })
		end,
	},
}
