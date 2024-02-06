if vim.g.neovide then
    FLOAT_OPTS = {
        border = "curved",
        width = function(_)
            return math.floor(vim.o.columns * 0.8)
        end,
        height = function(_)
            return math.floor(vim.o.lines * 0.8)
        end,
        winblend = 70,
    }
else
    FLOAT_OPTS = {
        border = "curved",
        width = function(_)
            return math.floor(vim.o.columns * 0.8)
        end,
        height = function(_)
            return math.floor(vim.o.lines * 0.8)
        end,
    }
end

return {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = {
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = FLOAT_OPTS,
        winbar = {
            enabled = false,
            name_formatter = function(term) --  term: Terminal
                return term.name
            end,
        },
    },
}
