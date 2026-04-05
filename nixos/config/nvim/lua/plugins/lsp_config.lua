return {
  
  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
    require("lsp_manager").setup_servers()
    end
  },


  -- Auto-complete (Blink.cmp)
  {
    "saghen/blink.cmp",
    version = "v0.*",
    opts = {
     keymap = {
      preset = "none", 
      ["<C-space>"] = { "show", "show_documentation", "hide" },
      ["<C-e>"] = { "hide" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
     },
      sources = {
        default = { "lsp", "path", "buffer" },
      },
      completion = {
        menu = {
          max_height = 6,
          auto_show = false,
        },
      },
    },
  },

}