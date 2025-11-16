# gitlink.nvim

`gitlink.nvim` is a lua plugin for neovim to open permalink link of current file in browser or copy the link to clipboard.
Which is inspired by [neovim-gitlink](https://marketplace.visualstudio.com/items?itemName=qezhu.gitlink)

## Installation

Using [nvim-plug](https://github.com/wsdjeg/nvim-plug)

```lua
require('plug').add({
    {
        'wsdjeg/gitlink.nvim',
    },
})
```

## Usage

```lua
vim.keymap.set('n', '<leader>fy', function()
    require('gitlink').copy()
end, { silent = true })
vim.keymap.set('n', '<leader>fY', function()
    require('gitlink').open()
end, { silent = true })
```
