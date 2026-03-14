-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Some OS detectors
local is_wsl = vim.fn.has("wsl") == 1
local is_linux = vim.fn.has("unix") == 1 and not is_wsl
-- local is_mac = vim.fn.has("macunix") == 1
-- local is_linux = not is_wsl and not is_mac

local opt = vim.opt

opt.autowrite = false
opt.confirm = false
opt.breakindent = true
-- opt.cindent = true
opt.visualbell = true

-- -- WSL Clipboard support
-- if is_wsl then
--   -- This is NeoVim's recommended way to solve clipboard sharing if you use WSL
--   -- See: https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
--   vim.g.clipboard = {
--     name = "WslClipboard",
--     copy = {
--       ["+"] = "clip.exe",
--       ["*"] = "clip.exe",
--     },
--     paste = {
--       ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--       ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     },
--     cache_enabled = 0,
--   }
-- end

vim.g.python3_host_prog = "/usr/bin/python3"

if is_wsl then
  vim.g.clipboard = {
    name = "wslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("\r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("\r", ""))',
    },
    cache_enabled = 0,
  }
elseif is_linux then
  vim.g.clipboard = {
    name = "xclipClipboard",
    copy = {
      ["+"] = "xclip -selection clipboard",
      ["*"] = "xclip -selection primary",
    },
    paste = {
      ["+"] = "xclip -selection clipboard -o",
      ["*"] = "xclip -selection primary -o",
    },
    cache_enabled = 0,
  }
end

-- Don't care about these
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
