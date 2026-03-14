-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- Add any additional keymaps here
--

-- local keymap = vim.keymap.set
-- keymap("n", "<S-h>", ":bp<CR>", { remap = true })
--
--
vim.api.nvim_set_keymap(
  "i",
  "<C-e>",
  "copilot#Accept('\\<CR>')",
  { noremap = true, silent = true, expr = true, script = true }
)
vim.g.copilot_no_tab_map = true
