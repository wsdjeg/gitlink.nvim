# gitlink.nvim

`gitlink.nvim` provide the feature that go to current file's online link in browser and copy the link in clipboard. Which is inspired by [neovim-gitlink](https://marketplace.visualstudio.com/items?itemName=qezhu.gitlink)


## Installation

```lua
require('plug').add({
    {
        'wsdjeg/gitlink.nvim',
        config = function()
            vim.keymap.set('n', '<leader>fy', function()
                require('gitlink').copy()
            end, { silent = true })
        end,
    },
})
```

