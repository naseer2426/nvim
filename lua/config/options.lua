-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Local session (monitor attached): xclip talks to the system clipboard directly.
-- SSH / no display: OSC 52 forwards yanks to the terminal's clipboard (Ghostty).
if vim.env.DISPLAY or vim.env.WAYLAND_DISPLAY then
  vim.g.clipboard = {
    name = "xclip",
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
else
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = osc52.paste("+"),
      ["*"] = osc52.paste("*"),
    },
  }
end
vim.opt.clipboard = "unnamedplus"

-- Keep some padding like VS Code
vim.opt.scrolloff = 5

-- Keep the terminal tab title fixed to the session's starting target.
local session_title = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
if vim.fn.argc() == 1 then
  local target = vim.fn.argv(0)
  if vim.fn.isdirectory(target) == 0 then
    session_title = vim.fn.fnamemodify(target, ":t")
  end
end

vim.opt.title = true
vim.opt.titlestring = session_title
