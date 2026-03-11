# Custom AstroNvim Configuration

Welcome to my custom Neovim configuration, based on the
[AstroNvim Template](https://github.com/AstroNvim/template) (for AstroNvim v5+).

This configuration provides a solid, extensible foundation using `lazy.nvim` as
the plugin manager.

## Prerequisites

Before installing, ensure you have the following dependencies installed on your
system:

- **Neovim** (>= `0.10`)
- **Ripgrep**
- **fzf**
- **A C Compiler**

## Installation

1. **Backup your existing configuration:**

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   mv ~/.local/state/nvim ~/.local/state/nvim.bak
   mv ~/.cache/nvim ~/.cache/nvim.bak
   ```

2. **Clone the repository:**

   ```bash
   git clone <your-repository-url> ~/.config/nvim
   ```

## Structure

- `init.lua`: The entry point that bootstraps `lazy.nvim` and loads the configuration.
- `lua/lazy_setup.lua`: Configures the plugins via `lazy.nvim`.
- `lua/polish.lua`: Add your custom Vimscript or extra Lua configuration here.
- `lua/plugins/`: Directory to place your custom plugin specifications.
