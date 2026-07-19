local M = {}

local util = require('gitlink.util')
local platform = require('gitlink.platform')

-- Convert various git remote URL formats to HTTPS URL
-- Handles: git@host:path.git, ssh://git@host/path.git, https://host/path.git
function M.remote_url_to_http(url)
    -- ssh:// protocol: ssh://[user@]host/path.git
    if vim.startswith(url, 'ssh://') then
        url = string.sub(url, 7) -- remove 'ssh://'
        -- Remove 'user@' if present
        url = url:gsub('^([^@]+)@', '')
        -- Remove '.git' suffix if present
        if vim.endswith(url, '.git') then
            url = string.sub(url, 1, -5)
        end
        return 'https://' .. url
    end

    -- SCP-style SSH: git@host:path.git or git@host:path
    if vim.startswith(url, 'git@') then
        url = string.sub(url, 5) -- remove 'git@'
        -- Remove '.git' suffix if present
        if vim.endswith(url, '.git') then
            url = string.sub(url, 1, -5)
        end
        -- Replace ':' with '/' (first occurrence, between host and path)
        url = url:gsub(':', '/', 1)
        return 'https://' .. url
    end

    -- HTTP(S) URLs: remove '.git' suffix if present
    if vim.endswith(url, '.git') then
        return string.sub(url, 1, -5)
    end
    return url
end

-- Get line range from current buffer
-- Returns line_start, line_end (line_end is nil for single line)
local function get_line_range()
    local mode = vim.fn.mode()
    if mode == 'v' or mode == 'V' or mode == '\22' then
        local start_line = vim.fn.line('v')
        local end_line = vim.fn.line('.')
        if start_line > end_line then
            start_line, end_line = end_line, start_line
        end
        if start_line ~= end_line then
            return start_line, end_line
        end
        return start_line, nil
    end
    -- Normal mode: check if '< mark is set (just left visual mode)
    local v_line = vim.fn.line('v')
    local cur_line = vim.fn.line('.')
    if v_line ~= cur_line and v_line > 0 then
        local start_line = math.min(v_line, cur_line)
        local end_line = math.max(v_line, cur_line)
        return start_line, end_line
    end
    return cur_line, nil
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
    url = M.remote_url_to_http(url)

    local commit = vim.trim(vim.system({ 'git', 'rev-parse', 'HEAD' }, { text = true }):wait().stdout)
    local path = vim.fs.normalize(vim.fn.fnamemodify(vim.fn.bufname(), ':.'))
    local line_start, line_end = get_line_range()

    -- Detect platform and build appropriate URL
    local detected_platform = platform.detect(url)
    util.debug('Detected platform: ' .. detected_platform)

    return platform.build_url(detected_platform, url, commit, path, line_start, line_end)
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

