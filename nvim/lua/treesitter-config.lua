require('nvim-treesitter.configs').setup {
  ensure_installed = { "python", "go", "elixir" }, -- Automatically install parsers for these languages
  highlight = {
    enable = true,              -- Enable syntax highlighting
  },
  indent = {
    enable = true,              -- Enable Tree-sitter-based indentation
  },
}

