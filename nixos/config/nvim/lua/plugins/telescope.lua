return {
  
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    -- Arquivos
    { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",           desc = "Recent files" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",            desc = "Open buffers" },
    -- Busca textual
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",          desc = "Search in project" },
    -- Git
    { "<leader>gs", "<cmd>Telescope git_status<cr>",         desc = "Git status" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>",        desc = "Git commits" },
    -- LSP
    { "<leader>lr", "<cmd>Telescope lsp_references<cr>",     desc = "References" },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = { preview_width = 0.40 },
      },
    },
  },

}