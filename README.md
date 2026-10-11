# Custom AstroNvim Configuration

Welcome to my custom Neovim configuration, based on the
[AstroNvim Template](https://github.com/AstroNvim/template) (for AstroNvim v5+).

This configuration provides a solid, extensible foundation using `lazy.nvim` as
the plugin manager.

## Installation

This setup uses Nix flakes and Home Manager to install Neovim and its external
tools on Linux and macOS (Intel and Apple Silicon). First install Nix using the
instructions at [nixos.org/download](https://nixos.org/download/). Then clone
this repository to `~/.config/nvim`, edit `nix/bundles.nix` to choose the
language bundles you want, and run:

```bash
./install
```

On standalone Home Manager, add the session setup to your login shell so the
Nix-installed tools are on `PATH`. For zsh, add this to `~/.zshrc`; for bash,
add it to `~/.bashrc`:

```bash
if [ -r "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi
```

Start a new shell after adding it. This is a one-time step; the installer
deliberately does not modify your existing shell configuration.

The installer builds a Home Manager profile from the pinned `flake.lock`.
Neovim plugins remain managed by `lazy.nvim`; Nix installs the external
programs used by the editor. When the Nix-generated bundle manifest is present,
Neovim loads only those bundles and Mason does not install duplicate tools.
Without Nix, Neovim retains its existing behavior and loads every bundle.
The pinned Nixpkgs 26.05 release is the final release supporting Intel Macs;
Apple Silicon Macs and Linux systems can move to newer releases when desired.
The installer requires Nix to be installed first; follow the official Nix
installer instructions once on each new machine.

The `latex` bundle is disabled by default because it installs a large TeX
distribution. Add `"latex"` to `nix/bundles.nix` if you need it. The chosen
bundles are also the packages Nix installs, so remove any bundle you do not
want before running the installer.
The `rust` bundle installs `cargo`, `rust-analyzer`, `rustfmt`, and Clippy;
the `python` and `ccpp` bundles install their language servers and tools too.

To update pinned dependencies later, run `nix flake update` in this directory,
review the `flake.lock` changes, and rerun `./install`.

The installer does not change your shell configuration or terminal font.
Install a Nerd Font in your terminal if you want AstroNvim's icons to render.

## Structure

- `init.lua`: The entry point that bootstraps `lazy.nvim` and loads the configuration.
- `lua/lazy_setup.lua`: Configures the plugins via `lazy.nvim`.
- `lua/polish.lua`: Add your custom Vimscript or extra Lua configuration here.
- `lua/plugins/`: Directory to place your custom plugin specifications.
- `lua/bundles/`: Language-specific tooling bundles, including Rust support.
- `nix/bundles.nix`: Language bundles to enable and install with Nix.
- `nix/home.nix` and `flake.nix`: Nix package set and portable Home Manager configuration.
