local M = {}

local util = require('gitlink.util')
local platform = require('gitlink.platform')

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
        util.notify('git is not executable.')
        return
    end
    local find_path = vim.fs.root(0, '.git')
    if not find_path then
        util.notify('not a git repository.')
        return
    end
    local remove_verbose_info = vim.tbl_filter(function(t)
        return vim.regex('(fetch)$'):match_str(t)
    end, vim.split(vim.system({ 'git', 'remote', '-v' }, { text = true }):wait().stdout, '\n'))[1]
    local url = vim.fn.split(remove_verbose_info)[2]
    url = remote_url_to_http(url)
    
    local commit = vim.trim(vim.system({ 'git', 'rev-parse', 'HEAD' }, { text = true }):wait().stdout)
    local path = vim.fs.normalize(vim.fn.fnamemodify(vim.fn.bufname(), ':.'))
    local line = vim.fn.line('.')
    
    -- Detect platform and build appropriate URL
    local detected_platform = platform.detect(url)
    util.debug('Detected platform: ' .. detected_platform)
    
    return platform.build_url(detected_platform, url, commit, path, line)
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
