---@module 'lazy'
---@type LazySpec
local M = {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = ':call mkdp#util#install()', -- https://github.com/iamcco/markdown-preview.nvim/issues/690#issuecomment-2510492642
}

return M
