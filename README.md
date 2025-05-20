# NVIM Setup for Nekronos

> [!Disclaimer]
> This is my personal NVIM configuration files with plugins. This is not intended for general use: keybindings are unusual, the plugin selection is not optimal, it hasn't been thoroughly tested, etc. I consider this NVIM instance as simple and flexible, withouth providing a lot of functionality.

> Anyhow, if you find this helpful or you have any recommendations, please feel free to reach out to me.

## Plugins
- Plugin Manager: *lazyvim*
- LSP Manager: *mason*
    - Autocompletion: *nvim-cmp*
        - Sources: *cmp-nvim-lsp*, *cmp-path*, *cmp-cmdline*, 
        - Brackets: *autopairs*
- Terminal: *toggleterm*
- Look And Feel
    - Status Line: *lualine*
    - Tabs: *tabline*
- File Explorer: *nvimtree*

## Editor Settings
- Colorscheme: *gruvbox*
- Keybindings
    - Open File Explorer: *Crtl + B*
    - New tab: *Crtl + N*
    - Next tab: *Crtl + L*
    - Previous tab: *Crtl + H*
    - Next buffer: *Shft + L*
    - Previous buffer: *Shft + H*
    - Toggle Terminal: *Crtl + T*
- Text
    - Numbering: *absolute*
    - Wrapping: *no*

## Languages
- Golang: *go.nvim*
