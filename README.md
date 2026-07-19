# gitlink.nvim

`gitlink.nvim` is a lightweight Neovim plugin that generates permalink
to the current file and line in your Git repository.
It auto-detects the Git hosting platform from your remote URL,
builds the correct permalink format, and lets you copy it to clipboard
or open it directly in the browser.
Whether you are on GitHub, GitLab, Bitbucket, Gitee, Codeberg, Gitea,
Sourcehut, or GitCode, `gitlink.nvim` has you covered.

[![Run Tests](https://github.com/wsdjeg/gitlink.nvim/actions/workflows/test.yml/badge.svg)](https://github.com/wsdjeg/gitlink.nvim/actions/workflows/test.yml)
[![GitHub License](https://img.shields.io/github/license/wsdjeg/gitlink.nvim)](LICENSE)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/wsdjeg/gitlink.nvim)](https://github.com/wsdjeg/gitlink.nvim/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/wsdjeg/gitlink.nvim)](https://github.com/wsdjeg/gitlink.nvim/commits/master/)
[![GitHub Release](https://img.shields.io/github/v/release/wsdjeg/gitlink.nvim)](https://github.com/wsdjeg/gitlink.nvim/releases)
[![luarocks](https://img.shields.io/luarocks/v/wsdjeg/gitlink.nvim)](https://luarocks.org/modules/wsdjeg/gitlink.nvim)

<!-- vim-markdown-toc GFM -->

- [✨ Features](#-features)
- [📦 Installation](#-installation)
- [🔧 Configuration](#-configuration)
- [⚙️ Usage](#️-usage)
- [🌐 Supported Platforms](#-supported-platforms)
- [📣 Self-Promotion](#-self-promotion)
- [💬 Feedback](#-feedback)
- [🙏 Credits](#-credits)
- [📄 License](#-license)

<!-- vim-markdown-toc -->

## ✨ Features

- Generate permalink for current file at current line
- Copy link to clipboard or open directly in browser
- Auto-detect Git platform from remote URL
- Support both HTTPS and SSH remote URLs
- Support line range links (select lines in visual mode)
- Support self-hosted instances (GitLab, Gitea)

## 📦 Installation

gitlink.nvim works with all major Neovim plugin managers.
Neovim 0.10+ and Git are required.

- **Using [nvim-plug](https://github.com/wsdjeg/nvim-plug)**

  ```lua
  require('plug').add({
    {
      'wsdjeg/gitlink.nvim',
    },
  })
  ```

- **Using [lazy.nvim](https://github.com/folke/lazy.nvim)**

  ```lua
  {
    'wsdjeg/gitlink.nvim',
    keys = {
      { '<leader>gy', function() require('gitlink').copy() end, desc = 'Copy git link' },
      { '<leader>gY', function() require('gitlink').open() end, desc = 'Open git link in browser' },
    },
  }
  ```

- **Using [packer.nvim](https://github.com/wbthomason/packer.nvim)**

  ```lua
  use({
    'wsdjeg/gitlink.nvim',
  })
  ```

- **Using [luarocks](https://luarocks.org/)**

  ```
  luarocks install gitlink.nvim
  ```

## 🔧 Configuration

```lua
require('gitlink').setup()
```

## ⚙️ Usage

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

| Function                    | Description                  |
| --------------------------- | ---------------------------- |
| `require('gitlink').copy()` | Copy permalink to clipboard  |
| `require('gitlink').open()` | Open permalink in browser    |

## 🌐 Supported Platforms

| Platform  | Single Line                              | Line Range                                 | Custom Domain Support           |
| --------- | ---------------------------------------- | ------------------------------------------ | ------------------------------- |
| GitHub    | `{url}/blob/{commit}/{path}#L10`         | `{url}/blob/{commit}/{path}#L10-L20`       | No                              |
| GitLab    | `{url}/-/blob/{commit}/{path}#L10`       | `{url}/-/blob/{commit}/{path}#L10-20`      | Yes (matches `gitlab.` pattern) |
| Bitbucket | `{url}/src/{commit}/{path}#lines-10`     | `{url}/src/{commit}/{path}#lines-10:20`    | No                              |
| Gitee     | `{url}/blob/{commit}/{path}#L10`         | `{url}/blob/{commit}/{path}#L10-L20`       | No                              |
| Codeberg  | `{url}/src/commit/{commit}/{path}#L10`   | `{url}/src/commit/{commit}/{path}#L10-L20` | No                              |
| Gitea     | `{url}/src/commit/{commit}/{path}#L10`   | `{url}/src/commit/{commit}/{path}#L10-L20` | Yes (matches `gitea.` pattern)  |
| Sourcehut | `{url}/tree/{commit}/item/{path}#L10`    | `{url}/tree/{commit}/item/{path}#L10-L20`  | No                              |
| GitCode   | `{url}/blob/{commit}/{path}#L10`         | `{url}/blob/{commit}/{path}#L10-L20`       | No                              |

## 📣 Self-Promotion

Like this plugin? Star the repository on
GitHub.

Love this plugin? Follow [me](https://wsdjeg.net/) on
[GitHub](https://github.com/wsdjeg).

## 💬 Feedback

If you encounter a bug or have a feature request,
please [open an issue](https://github.com/wsdjeg/gitlink.nvim/issues).

## 🙏 Credits

- [neovim-gitlink](https://marketplace.visualstudio.com/items?itemName=qezhu.gitlink)

## 📄 License

This project is licensed under the GPL-3.0 License.

