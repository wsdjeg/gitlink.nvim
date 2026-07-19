# gitlink.nvim

A Lua plugin for Neovim to generate and open permalink of current file in browser or copy the link to clipboard.

[![Run Tests](https://github.com/wsdjeg/gitlink.nvim/actions/workflows/test.yml/badge.svg)](https://github.com/wsdjeg/gitlink.nvim/actions/workflows/test.yml)
[![GitHub License](https://img.shields.io/github/license/wsdjeg/gitlink.nvim)](LICENSE)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/wsdjeg/gitlink.nvim)](https://github.com/wsdjeg/gitlink.nvim/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/wsdjeg/gitlink.nvim)](https://github.com/wsdjeg/gitlink.nvim/commits/master/)
[![GitHub Release](https://img.shields.io/github/v/release/wsdjeg/gitlink.nvim)](https://github.com/wsdjeg/gitlink.nvim/releases)
[![luarocks](https://img.shields.io/luarocks/v/wsdjeg/gitlink.nvim)](https://luarocks.org/modules/wsdjeg/gitlink.nvim)

<!-- vim-markdown-toc GFM -->

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Supported Platforms](#supported-platforms)
- [Credits](#credits)
- [Self-Promotion](#self-promotion)
- [License](#license)

<!-- vim-markdown-toc -->

## Features

- 🚀 Generate permalink for current file at current line
- 📋 Copy link to clipboard
- 🌐 Open link directly in browser
- 🔍 Auto-detect Git platform from remote URL
- 🔗 Support both HTTPS and SSH remote URLs
- 📏 Support line range links (select lines in visual mode)
- 🏠 Support self-hosted instances (GitLab, Gitea)

## Requirements

- Neovim >= 0.10.0
- Git

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    'wsdjeg/gitlink.nvim',
    keys = {
        { '<leader>gy', function() require('gitlink').copy() end, desc = 'Copy git link' },
        { '<leader>gY', function() require('gitlink').open() end, desc = 'Open git link in browser' },
    },
}
```

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
-- Copy git link to clipboard (normal mode: current line, visual mode: selected range)
vim.keymap.set({ 'n', 'x' }, '<leader>gy', function()
    require('gitlink').copy()
end, { silent = true, desc = 'Copy git link' })

-- Open git link in browser (normal mode: current line, visual mode: selected range)
vim.keymap.set({ 'n', 'x' }, '<leader>gY', function()
    require('gitlink').open()
end, { silent = true, desc = 'Open git link in browser' })
```

- **Normal mode**: generates a single-line permalink (`#L10`)
- **Visual mode**: generates a line range permalink (e.g. `#L10-L20`)

| Function                    | Description                                   |
| --------------------------- | --------------------------------------------- |
| `require('gitlink').copy()` | Copy permalink to clipboard                   |
| `require('gitlink').open()` | Open permalink in browser                     |

## Configuration

```lua
require('gitlink').setup()
```

## Supported Platforms

| Platform  | Single Line                               | Line Range                                  | Custom Domain Support           |
| --------- | ----------------------------------------- | ------------------------------------------- | ------------------------------- |
| GitHub    | `{url}/blob/{commit}/{path}#L10`          | `{url}/blob/{commit}/{path}#L10-L20`        | No                              |
| GitLab    | `{url}/-/blob/{commit}/{path}#L10`        | `{url}/-/blob/{commit}/{path}#L10-20`       | Yes (matches `gitlab.` pattern) |
| Bitbucket | `{url}/src/{commit}/{path}#lines-10`      | `{url}/src/{commit}/{path}#lines-10:20`     | No                              |
| Gitee     | `{url}/blob/{commit}/{path}#L10`          | `{url}/blob/{commit}/{path}#L10-L20`        | No                              |
| Codeberg  | `{url}/src/commit/{commit}/{path}#L10`    | `{url}/src/commit/{commit}/{path}#L10-L20`  | No                              |
| Gitea     | `{url}/src/commit/{commit}/{path}#L10`    | `{url}/src/commit/{commit}/{path}#L10-L20`  | Yes (matches `gitea.` pattern)  |
| Sourcehut | `{url}/tree/{commit}/item/{path}#L10`     | `{url}/tree/{commit}/item/{path}#L10-L20`   | No                              |
| GitCode   | `{url}/blob/{commit}/{path}#L10`          | `{url}/blob/{commit}/{path}#L10-L20`        | No                              |

## Credits

- [neovim-gitlink](https://marketplace.visualstudio.com/items?itemName=qezhu.gitlink)

## Self-Promotion

Like this plugin? Star the repository on
GitHub.

Love this plugin? Follow [me](https://wsdjeg.net/) on
[GitHub](https://github.com/wsdjeg).

## License

This project is licensed under the GPL-3.0 License.

