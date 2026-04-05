-- ~/.config/nvim/lua/keymaps.lua

local opts = { silent = true }


-- 'jj' para sair do modo insert
vim.keymap.set({ 'i', 'v' }, 'jj', '<Esc>', { silent = true })

-- Ctrl+s = salvar
vim.keymap.set({ 'n', 'v', 'i' }, '<C-s>', '<Cmd>w!<CR>', { silent = true })

-- Ctrl+q = sair sem salvar
vim.keymap.set({ 'n', 'v', 'i' }, '<C-q>', '<Cmd>q!<CR>', { silent = true })


-- Search
vim.opt.ignorecase  = true          
vim.opt.smartcase   = true          
vim.opt.hlsearch    = false         
vim.opt.incsearch   = true          

-- Interface
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.wrap           = true 
vim.opt.linebreak = true       
vim.opt.breakindent = true      

-- Indentação
vim.opt.smartindent = true

--  Performance / timings
vim.opt.updatetime  = 300       
vim.opt.timeoutlen  = 300  

-- Clipboard / sistema
vim.opt.clipboard:append("unnamedplus")

-- Undo, swap e backup
vim.opt.undofile = true
vim.opt.undodir  = vim.fn.expand("~/.vim/undodir")   -- precisa criar a pasta antes: mkdir -p ~/.vim/undodir
vim.opt.swapfile = false
vim.opt.backup   = false

-- Interface complementar
vim.opt.signcolumn  = "yes"       
vim.opt.colorcolumn = "100"
vim.opt.pumheight   = 6            
