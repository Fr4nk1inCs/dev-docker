if vim.g.vscode then
    return {}
end

return {
    -- NightFox Colorscheme
    {
        "EdenEast/nightfox.nvim",
        opts = {
            options = {
                transparent = true,
            },
            palettes = {
                all = {
                    -- Make the background of statusline and bufferline transparent
                    bg0 = "NONE",
                },
            },
        },
    },

    -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "nordfox",
        },
    },
}
