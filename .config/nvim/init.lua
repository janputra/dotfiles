vim.opt.clipboard = "unnamedplus"
vim.opt.nu = true -- Enable absolute line numbers
vim.opt.relativenumber = true -- Enable relative line numbers
vim.opt.statuscolumn = "%s %l %r" -- Customize statuscolumn to display both

-- Set ignorecase to true for case-insensitive searching by default
vim.o.ignorecase = true

-- Set smartcase to true to override ignorecase if the search pattern contains uppercase characters
vim.o.smartcase = true
