if vim.g.vscode then
    return {}
end

return {
    "akinsho/toggleterm.nvim",
    opts = {
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
            border = "curved",
            width = function(_)
                return math.floor(vim.o.columns * 0.8)
            end,
            height = function(_)
                return math.floor(vim.o.lines * 0.8)
            end,
        },
        winbar = {
            enabled = false,
            name_formatter = function(term) --  term: Terminal
                return term.name
            end,
        },
    },
}
