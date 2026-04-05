return {

  'mg979/vim-visual-multi',
  branch = 'master',
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_quit_after_leaving_insert_mode = 1
    vim.g.VM_maps = {
      ['Find Under']         = '<C-n>',
      ['Find Subword Under'] = '<C-n>',
      ['Exit']               = '<Esc>',
    }
 end,

}