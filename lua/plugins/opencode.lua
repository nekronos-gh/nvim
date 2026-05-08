return {
  "nickjvandyke/opencode.nvim",
  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {},
        terminal = {},
      },
    },
  },
  config = function()
    vim.o.autoread = true

    vim.keymap.set(
      { "n", "x" },
      "<C-a>",
      function() require("opencode").ask("@this: ", { submit = true }) end,
      { desc = "Ask opencode…" }
    )

    local function toggle_opencode_tab()
      local current_tab = vim.api.nvim_get_current_tabpage()
      local opencode_tab = nil
      local opencode_win = nil

      -- Find if an OpenCode tab already exists
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        local wins = vim.api.nvim_tabpage_list_wins(tab)
        for _, win in ipairs(wins) do
          local b = vim.api.nvim_win_get_buf(win)
          if vim.bo[b].buftype == "terminal" and vim.api.nvim_buf_get_name(b):match "opencode" then
            opencode_tab = tab
            opencode_win = win
            break
          end
        end
        if opencode_tab then
          break
        end
      end

      if opencode_tab then
        if current_tab == opencode_tab then
          -- We are in OpenCode tab, go back to previous tab
          local ok, prev = pcall(vim.api.nvim_tabpage_get_var, opencode_tab, "opencode_prev_tab")
          if ok and prev and vim.api.nvim_tabpage_is_valid(prev) then
            vim.api.nvim_set_current_tabpage(prev)
          else
            vim.cmd "tabprevious"
          end
        else
          -- Switch to existing OpenCode tab
          vim.api.nvim_tabpage_set_var(opencode_tab, "opencode_prev_tab", current_tab)
          vim.api.nvim_set_current_tabpage(opencode_tab)
          if opencode_win and vim.api.nvim_win_is_valid(opencode_win) then
            vim.api.nvim_set_current_win(opencode_win)
          end
        end
      else
        -- Create new tab and open OpenCode
        local prev_tab = current_tab
        vim.cmd "tabnew"
        local new_tab = vim.api.nvim_get_current_tabpage()
        vim.api.nvim_tabpage_set_var(new_tab, "opencode_prev_tab", prev_tab)
        require("opencode").toggle()

        -- Find the OpenCode window, focus it, and make it the only window
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(new_tab)) do
          local b = vim.api.nvim_win_get_buf(win)
          if vim.bo[b].buftype == "terminal" and vim.api.nvim_buf_get_name(b):match "opencode" then
            vim.api.nvim_set_current_win(win)
            vim.cmd "only"
            break
          end
        end
      end
    end

    vim.keymap.set({ "n", "t" }, "<leader>a", toggle_opencode_tab, { desc = "Toggle OpenCode tab", noremap = true })

    vim.keymap.set(
      { "n", "x" },
      "go",
      function() return require("opencode").operator "@this " end,
      { desc = "Add range to opencode", expr = true }
    )

    vim.keymap.set(
      "n",
      "goo",
      function() return require("opencode").operator "@this " .. "_" end,
      { desc = "Add line to opencode", expr = true }
    )

    vim.keymap.set(
      "n",
      "<S-C-u>",
      function() require("opencode").command "session.half.page.up" end,
      { desc = "Scroll opencode up" }
    )

    vim.keymap.set(
      "n",
      "<S-C-d>",
      function() require("opencode").command "session.half.page.down" end,
      { desc = "Scroll opencode down" }
    )
  end,
}
