local M = {}

local function remote_url_to_http(url)
    if vim.startswith(url, 'git@') then
        return 'https://' .. vim.fn.substitute(string.sub(url, 5, -5), ':', '/', 'g')
    else
        if vim.endswith(url, '.git') then
            return string.sub(url, 1, -5)
        else
            return url
        end
    end
end

local function get_url()
    if vim.fn.executable('git') == 0 then
        require('gitlink.util').notify('git is not executable!')
        return
    end
    local find_path = vim.fs.root(0, '.git')
    local remove_verbose_info = vim.tbl_filter(function(t)
        return vim.regex('(fetch)$'):match_str(t)
    end, vim.split(vim.system({ 'git', 'remote', '-v' }, { text = true }):wait().stdout, '\n'))[1]
    local remote = vim.fn.split(remove_verbose_info)[1]
    local url = vim.fn.split(remove_verbose_info)[2]
    url = remote_url_to_http(url)
    return url
        .. '/blob/'
        .. vim.trim(vim.system({ 'git', 'rev-parse', 'HEAD' }, { text = true }):wait().stdout)
        .. '/'
        .. vim.fs.normalize(vim.fn.fnamemodify(vim.fn.bufname(), ':.'))
        .. '#L'
        .. vim.fn.line('.')
end

function M.open()
    local url = get_url()
    if url then
        vim.ui.open(url)
    end
end

function M.copy()
    local url = get_url()
    if url then
        vim.fn.setreg('+', url)
    end
end

function M.setup() end

return M
