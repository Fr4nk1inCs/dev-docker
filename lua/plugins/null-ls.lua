return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        opts = function()
            local nls = require("null-ls")
            return {
                root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
                sources = {
                    nls.builtins.formatting.fish_indent,
                    nls.builtins.diagnostics.fish,
                    nls.builtins.formatting.stylua,
                    nls.builtins.formatting.shfmt,
                    nls.builtins.formatting.autopep8,
                    nls.builtins.formatting.clang_format,
                    nls.builtins.formatting.rustfmt,
                    nls.builtins.diagnostics.flake8,
                },
            }
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                automatic_installation = true,
                automatic_setup = true,
                handlers = nil,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            autoformat = true,
        },
    },
}
