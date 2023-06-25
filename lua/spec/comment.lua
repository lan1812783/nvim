local comment = {
  "numToStr/Comment.nvim",
  dependencies = {
    -- This plugin does not depend on nvim-treesitter however it is recommended in order to easily install tree-sitter parsers.
    {
      'nvim-treesitter/nvim-treesitter',
      build = function()
        require('nvim-treesitter.install').update({ with_sync = true })
      end,
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
}

function comment.config()
  local Comment = require('Comment')

  local opts = {
    -- ignores empty lines
    ignore = '^$'
  }

  Comment.setup(opts)
end

return comment
