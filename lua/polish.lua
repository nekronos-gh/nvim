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

-- Share clipboard wherever (guarded so Docker/headless won't fail)
local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
if ok then
  vim.g.clipboard = {
    name = "osc52 (copy only)",
    copy = {
      ["+"] = osc52.copy "+",
      ["*"] = osc52.copy "*",
    },
    paste = {
      -- Don't query terminal clipboard (prevents timeouts)
      ["+"] = function() return 0 end,
      ["*"] = function() return 0 end,
    },
  }
end
