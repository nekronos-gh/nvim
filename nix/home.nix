{ pkgs, lib, ... }:
let
  enabledBundles = import ./bundles.nix;

  bundlePackages = {
    python = with pkgs; [
      pyright
      black
      isort
      ruff
      mypy
      pylint
      (python3.withPackages (pythonPackages: [ pythonPackages.debugpy ]))
    ];

    ccpp = with pkgs; [
      clang-tools
    ];

    rust = with pkgs; [
      cargo
      rustc
      rust-analyzer
      rustfmt
      clippy
    ];

    latex = with pkgs; [
      texlab
      texlivePackages.chktex
      texlivePackages.latexindent
      texlivePackages.latexmk
      texlive.combined.scheme-medium
    ];
  };

  unknownBundles = builtins.filter (bundle: !(builtins.hasAttr bundle bundlePackages)) enabledBundles;
  selectedPackages = lib.concatMap (bundle: bundlePackages.${bundle}) enabledBundles;
  luaBundleManifest =
    "return { " + builtins.concatStringsSep ", " (map builtins.toJSON enabledBundles) + " }\n";
in
assert unknownBundles == [ ];
{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    neovim
    git
    ripgrep
    fzf
    fd
    curl
    opencode
    stdenv.cc
    gnumake
    tree-sitter

    lua-language-server
    stylua
    bash-language-server
    shellcheck
    shfmt
    selene
    vscode-langservers-extracted
    marksman
    taplo
    prettier
    yaml-language-server
    yamlfmt
    markdownlint-cli
    yamllint
  ] ++ selectedPackages;

  xdg.dataFile."nvim/nix-bundles.lua".text = luaBundleManifest;

  programs.home-manager.enable = true;
}
