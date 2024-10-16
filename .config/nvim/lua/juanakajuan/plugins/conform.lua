return {
    "stevearc/conform.nvim",
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>fm",
            function()
                require("conform").format { async = true, lsp_fallback = true }
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {},
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "isort", "black" },
                -- Use a sub-list to run only the first available formatter
                java = { "clang-format" },
                cpp = { "clang-format" },
                typescriptreact = { "prettierd" },
                javascriptreact = { "prettierd" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                volar = { "prettierd" },
            },
        }
    end,
}
