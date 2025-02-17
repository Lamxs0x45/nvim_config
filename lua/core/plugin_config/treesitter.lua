local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "c", "rust", "python", "javascript"},
  highlight = { enable = true },
  indent = { enable = true },
})

