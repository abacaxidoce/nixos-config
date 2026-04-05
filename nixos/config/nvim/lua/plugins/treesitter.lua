return {

  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = { "rust", "c", "lua", "json" },
    highlight = { 
      enable = true, 
      additional_vim_regex_highlighting = false, 
    },
    indent = { enable = true },
  },
  
}