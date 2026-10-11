---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    commit = "5052189882442cf71e04ad2d5472ee31bfe6a5cf",
  },
  {
    "AstroNvim/astrolsp",
    commit = "0befe28a4ea96e46b7f7c01e4a634c04225ba55a",
  },
  {
    "AstroNvim/astroui",
    commit = "4943abbd42674b43249313afe83b91065a40e4be",
  },
  {
    "neovim/nvim-lspconfig",
    commit = "fa2662510d30b06168b6e2e6915518decde6bbac",
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },
}
