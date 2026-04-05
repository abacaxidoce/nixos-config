local M = {}

M.setup_servers = function()
  vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
    float = { border = "rounded", source = "always" },
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok_blink, blink = pcall(require, "blink.cmp")
  if ok_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end

  local lsp_dir = vim.fn.stdpath("config") .. "/lua/lsp"
  local files = vim.fn.globpath(lsp_dir, "*.lua", false, true)

  for _, file in ipairs(files) do
    local server_name = vim.fn.fnamemodify(file, ":t:r")

    local chunk = loadfile(file)
    local custom_opts = {}
    if chunk then
      local ok, result = pcall(chunk)
      if ok and type(result) == "table" then custom_opts = result end
    end

    local final_config = vim.tbl_deep_extend("force", {
      capabilities = capabilities,
    }, custom_opts)

    pcall(vim.lsp.enable, server_name, final_config)
  end
end

return M