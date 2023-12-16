if vim.g.vscode then
    return {}
end

if vim.g.neovide then
    OPTS = {}
else
    OPTS = {
        options = {
            transparent = true,
        },
        palettes = {
            all = {
                -- Make the background of statusline and bufferline transparent
                bg0 = "NONE",
            },
        },
    }
end

return {
    -- NightFox Colorscheme
    {
        "EdenEast/nightfox.nvim",
        opts = OPTS,
    },

    -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "nordfox",
        },
    },
}
