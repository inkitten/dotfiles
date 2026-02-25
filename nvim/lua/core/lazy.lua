-- Setup lazy.vim
require("lazy").setup({
    spec = {
    { import = "plugins" },
    },
    install = { colorscheme = {"catppuccin"}, "vim" }
})
