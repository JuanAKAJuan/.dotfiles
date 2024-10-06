-- NOTE: This is where your plugins related to LSP can be installed.
--  The configuration is done below. Search for lspconfig to find it below.
return {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { "j-hui/fidget.nvim",       opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        "folke/neodev.nvim",
    },

    config = function()
        -- [[ Configure LSP ]]
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(_, bufnr)
            -- NOTE: Remember that lua is a real programming language, and as such it is possible
            -- to define small helper and utility functions so you don't have to repeat yourself
            -- many times.
            --
            -- In this case, we create a function that lets us more easily define mappings specific
            -- for LSP related items. It sets the mode, buffer and description for us each time.
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
            nmap("<leader>ca", function()
                vim.lsp.buf.code_action {
                    context = { only = { "quickfix", "refactor", "source" } },
                }
            end, "[C]ode [A]ction")
            vim.keymap.set(
                "n",
                "gd",
                vim.lsp.buf.definition,
                { buffer = bufnr, desc = "LSP Definition" }
            )
            nmap(
                "gd",
                require("telescope.builtin").lsp_definitions,
                "[G]oto [D]efinition"
            )
            nmap(
                "gr",
                require("telescope.builtin").lsp_references,
                "[G]oto [R]eferences"
            )
            nmap(
                "gI",
                require("telescope.builtin").lsp_implementations,
                "[G]oto [I]mplementation"
            )
            nmap(
                "<leader>D",
                require("telescope.builtin").lsp_type_definitions,
                "Type [D]efinition"
            )
            nmap(
                "<leader>ds",
                require("telescope.builtin").lsp_document_symbols,
                "[D]ocument [S]ymbols"
            )
            nmap(
                "<leader>ws",
                require("telescope.builtin").lsp_dynamic_workspace_symbols,
                "[W]orkspace [S]ymbols"
            )

            -- See `:help K` for why this keymap
            nmap("K", vim.lsp.buf.hover, "Hover Documentation")
            nmap("L", vim.lsp.buf.signature_help, "Signature Documentation")

            -- Lesser used LSP functionality
            nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            nmap(
                "<leader>wa",
                vim.lsp.buf.add_workspace_folder,
                "[W]orkspace [A]dd Folder"
            )
            nmap(
                "<leader>wr",
                vim.lsp.buf.remove_workspace_folder,
                "[W]orkspace [R]emove Folder"
            )
            nmap("<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, "[W]orkspace [L]ist Folders")

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })
        end

        -- document existing key chains
        require("which-key").add {
            { "<leader>c",  group = "[C]ode" },
            { "<leader>c_", hidden = true },
            { "<leader>d",  group = "[D]ocument" },
            { "<leader>d_", hidden = true },
            { "<leader>g",  group = "[G]it" },
            { "<leader>g_", hidden = true },
            { "<leader>h",  group = "Git [H]unk" },
            { "<leader>h_", hidden = true },
            { "<leader>r",  group = "[R]ename" },
            { "<leader>r_", hidden = true },
            { "<leader>s",  group = "[S]earch" },
            { "<leader>s_", hidden = true },
            { "<leader>t",  group = "[T]oggle" },
            { "<leader>t_", hidden = true },
            { "<leader>w",  group = "[W]orkspace" },
            { "<leader>w_", hidden = true },
        }

        -- register which-key VISUAL mode
        -- required for visual <leader>hs (hunk stage) to work
        require("which-key").add {
            { "<leader>",  group = "VISUAL <leader>", mode = "v" },
            { "<leader>h", desc = "Git [H]unk",       mode = "v" },
        }

        -- mason-lspconfig requires that these setup functions are called in this order
        -- before setting up the servers.
        require("mason").setup()

        require("mason-lspconfig").setup()

        --  Add any additional override configuration in the following tables. They will be passed to
        --  the `settings` field of the server config. You must look up that documentation yourself.
        local servers = {
            jdtls = {},
            clangd = {
                hint = { enable = true },
            },
            -- gopls = {},
            pyright = {
                hint = { enable = true },
            },
            -- rust_analyzer = {},
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                    -- diagnostics = { disable = { 'missing-fields' } },
                    hint = { enable = true },
                },
            },
        }

        -- Setup neovim lua configuration
        require("neodev").setup()

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities =
            require("cmp_nvim_lsp").default_capabilities(capabilities)

        require("flutter-tools").setup {
            lsp = {
                on_attach = on_attach,
                capabilties = capabilities,
            },
        }

        -- Ensure the servers above are installed
        local mason_lspconfig = require "mason-lspconfig"

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                -- if server_name ~= "jdtls" then
                require("lspconfig")[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                    handlers = {
                        ["$/progress"] = function(_, result, ctx)
                            -- disable progress updates.
                        end,
                    },
                }
                -- end
            end,
        }
    end,
}
