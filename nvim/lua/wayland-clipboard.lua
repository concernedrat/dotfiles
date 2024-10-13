if vim.fn.has('clipboard') then
  vim.opt.clipboard = 'unnamedplus'
  vim.g.clipboard = {
    name = 'wl-clipboard',
    copy = {
      ['+'] = 'wl-copy --foreground --type text/plain',
      ['*'] = 'wl-copy --foreground --type text/plain',
    },
    paste = {
      ['+'] = 'wl-paste --no-newline',
      ['*'] = 'wl-paste --no-newline',
    },
  }
end

