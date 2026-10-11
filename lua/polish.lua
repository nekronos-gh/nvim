-- Set automatic read on file change
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "checktime",
})

-- Select zsh if available
if vim.fn.executable "zsh" == 1 then vim.opt.shell = "zsh" end

-- Terminal config
vim.keymap.set({ "n", "t" }, "<C-.>", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle terminal" })
-- Auto-quit safely when jobs (e.g., ToggleTerm) are running
vim.api.nvim_create_user_command("QA", function()
  -- Save all buffers and quit silently
  vim.cmd "wa"
  vim.cmd "silent! qall!"
end, { desc = "Save all, close terminals, and quit safely" })

-- Optional: remap standard :qa to this safe version
vim.keymap.set("n", "<leader>q", ":QA<CR>", { desc = "Safe quit all" })

-- Share the system clipboard over OSC 52 where supported.
vim.o.clipboard = "unnamedplus"

local function paste()
  return {
    vim.fn.split(vim.fn.getreg "", "\n"),
    vim.fn.getregtype "",
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy "+",
    ["*"] = require("vim.ui.clipboard.osc52").copy "*",
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

require("illuminate").configure {
  providers = {
    "lsp",
    "regex",
  },
}
