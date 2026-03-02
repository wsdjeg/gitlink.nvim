# gitlink.nvim

A lua plugin for neovim to open permalink link of current file in browser or copy the link to clipboard.

[![Run Tests](https://github.com/wsdjeg/gitlink.nvim/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/wsdjeg/gitlink.nvim/actions/workflows/test.yml)
[![GitHub License](https://img.shields.io/github/license/wsdjeg/gitlink.nvim)](LICENSE)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/wsdjeg/gitlink.nvim)](https://github.com/wsdjeg/gitlink.nvim/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/wsdjeg/gitlink.nvim)](https://github.com/wsdjeg/gitlink.nvim/commits/master/)
[![GitHub Release](https://img.shields.io/github/v/release/wsdjeg/gitlink.nvim)](https://github.com/wsdjeg/gitlink.nvim/releases)
[![luarocks](https://img.shields.io/luarocks/v/wsdjeg/gitlink.nvim)](https://luarocks.org/modules/wsdjeg/gitlink.nvim)

<!-- vim-markdown-toc GFM -->

- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [Self-Promotion](#self-promotion)
- [License](#license)

<!-- vim-markdown-toc -->

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

## Credits

- [neovim-gitlink](https://marketplace.visualstudio.com/items?itemName=qezhu.gitlink)

## Self-Promotion

Like this plugin? Star the repository on
GitHub.

Love this plugin? Follow [me](https://wsdjeg.net/) on
[GitHub](https://github.com/wsdjeg).

## License

This project is licensed under the GPL-3.0 License.
