local M = {}

-- Extract domain from various URL formats (http, ssh, scp-style)
local function extract_domain(url)
    if not url or url == '' then
        return ''
    end
    -- SCP-style SSH: git@host:path
    local domain = url:match('^git@([^:]+)')
    if domain then
        return domain
    end
    -- ssh:// protocol: ssh://[user@]host/path
    domain = url:match('^ssh://[^@]*@?([^/]+)')
    if domain then
        return domain
    end
    -- HTTP(S): http(s)://host/path
    domain = url:match('^https?://([^/]+)')
    if domain then
        return domain
    end
    return ''
end

-- Platform definitions with their URL patterns
local platforms = {
    github = {
        domains = { 'github.com' },
        url_format = function(base_url, commit, path, line_start, line_end)
            local fragment = '#L' .. line_start
            if line_end and line_end ~= line_start then
                fragment = string.format('#L%d-L%d', line_start, line_end)
            end
            return string.format('%s/blob/%s/%s%s', base_url, commit, path, fragment)
        end,
    },
    gitlab = {
        domains = { 'gitlab.com' },
        url_format = function(base_url, commit, path, line_start, line_end)
            local fragment = '#L' .. line_start
            if line_end and line_end ~= line_start then
                fragment = string.format('#L%d-%d', line_start, line_end)
            end
            return string.format('%s/-/blob/%s/%s%s', base_url, commit, path, fragment)
        end,
        custom_detector = function(url)
            local patterns = { 'gitlab%.', '%.gitlab%.com' }
            for _, pattern in ipairs(patterns) do
                if url:match(pattern) then
                    return true
                end
            end
            return false
        end,
    },
    bitbucket = {
        domains = { 'bitbucket.org' },
        url_format = function(base_url, commit, path, line_start, line_end)
            local fragment = string.format('#lines-%d', line_start)
            if line_end and line_end ~= line_start then
                fragment = string.format('#lines-%d:%d', line_start, line_end)
            end
            return string.format('%s/src/%s/%s%s', base_url, commit, path, fragment)
        end,
    },
    gitee = {
        domains = { 'gitee.com' },
        url_format = function(base_url, commit, path, line_start, line_end)
            local fragment = '#L' .. line_start
            if line_end and line_end ~= line_start then
                fragment = string.format('#L%d-L%d', line_start, line_end)
            end
            return string.format('%s/blob/%s/%s%s', base_url, commit, path, fragment)
        end,
    },
    codeberg = {
        domains = { 'codeberg.org' },
        url_format = function(base_url, commit, path, line_start, line_end)
            local fragment = '#L' .. line_start
            if line_end and line_end ~= line_start then
                fragment = string.format('#L%d-L%d', line_start, line_end)
            end
            return string.format('%s/src/commit/%s/%s%s', base_url, commit, path, fragment)
        end,
    },
    gitea = {
        domains = { 'gitea.com' },
        url_format = function(base_url, commit, path, line_start, line_end)
            local fragment = '#L' .. line_start
            if line_end and line_end ~= line_start then
                fragment = string.format('#L%d-L%d', line_start, line_end)
            end
            return string.format('%s/src/commit/%s/%s%s', base_url, commit, path, fragment)
        end,
        custom_detector = function(url)
            local patterns = { 'gitea%.', '%.gitea%.com' }
            for _, pattern in ipairs(patterns) do
                if url:match(pattern) then
                    return true
                end
            end
            return false
        end,
    },
    sourcehut = {
        domains = { 'git.sr.ht' },
        url_format = function(base_url, commit, path, line_start, line_end)
            local fragment = '#L' .. line_start
            if line_end and line_end ~= line_start then
                fragment = string.format('#L%d-L%d', line_start, line_end)
            end
            return string.format('%s/tree/%s/item/%s%s', base_url, commit, path, fragment)
        end,
    },
    gitcode = {
        domains = { 'gitcode.com' },
        url_format = function(base_url, commit, path, line_start, line_end)
            local fragment = '#L' .. line_start
            if line_end and line_end ~= line_start then
                fragment = string.format('#L%d-L%d', line_start, line_end)
            end
            return string.format('%s/blob/%s/%s%s', base_url, commit, path, fragment)
        end,
    },
}

-- Detect platform from URL
function M.detect(url)
    if not url or url == '' then
        return 'github' -- default to GitHub
    end

    local domain = extract_domain(url)

    -- Check each platform
    for platform_name, platform_config in pairs(platforms) do
        -- Check domain list
        for _, platform_domain in ipairs(platform_config.domains) do
            if domain:find(platform_domain, 1, true) then
                return platform_name
            end
        end

        -- Check custom detector
        if platform_config.custom_detector then
            if platform_config.custom_detector(url) then
                return platform_name
            end
        end
    end

    -- Default to GitHub
    return 'github'
end

-- Build URL for specific platform
function M.build_url(platform_name, base_url, commit, path, line_start, line_end)
    local p = platforms[platform_name]
    if not p then
        p = platforms.github
    end

    return p.url_format(base_url, commit, path, line_start, line_end)
end

-- Get all supported platforms
function M.get_platforms()
    return vim.tbl_keys(platforms)
end

-- Get platform info (domains, has custom detector)
function M.get_platform_info(name)
    local p = platforms[name]
    if not p then
        return nil
    end
    return {
        name = name,
        domains = p.domains,
        has_custom_detector = p.custom_detector ~= nil,
    }
end

return M

