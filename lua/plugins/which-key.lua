if vim.g.vscode then
    return {}
end

return {
    "folke/which-key.nvim",
    opts = {
        window = { border = "rounded" },
    },
}
